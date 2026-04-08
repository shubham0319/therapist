import 'package:therapist/core/error/failures.dart';
import 'package:therapist/core/network/grpc_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Returned by every auth call — contains what the backend told us.
class TherapistSession {
  const TherapistSession({required this.therapistId, required this.status});
  final String therapistId;
  final String status; // needs_onboarding | pending | verified | rejected
}

typedef AuthResult<T> = Future<({Failure? failure, T? value})>;

extension _Either<T> on ({Failure? failure, T? value}) {
  void fold(void Function(Failure) onLeft, void Function(T) onRight) {
    if (failure != null) {
      onLeft(failure!);
    } else {
      onRight(value as T);
    }
  }
}

class AuthRepository {
  AuthRepository({required SupabaseClient supabase, required GrpcClient grpc})
      : _supabase = supabase,
        _grpc = grpc;

  final SupabaseClient _supabase;
  final GrpcClient _grpc;

  Future<({Failure? failure, TherapistSession? value})> getCurrentSession() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session == null) {
        return (failure: const AuthFailure('No active session'), value: null);
      }
      return _callAuthCallback(session.accessToken);
    } catch (e) {
      return (failure: UnexpectedFailure(e.toString()), value: null);
    }
  }

  Future<({Failure? failure, TherapistSession? value})> signInWithGoogle() async {
    try {
      await _supabase.auth.signInWithOAuth(OAuthProvider.google);
      final session = _supabase.auth.currentSession;
      if (session == null) {
        return (failure: const AuthFailure('Google sign-in failed'), value: null);
      }
      return _callAuthCallback(session.accessToken);
    } catch (e) {
      return (failure: AuthFailure(e.toString()), value: null);
    }
  }

  Future<({Failure? failure, void value})> sendEmailOtp(String email) async {
    try {
      await _supabase.auth.signInWithOtp(email: email);
      return (failure: null, value: null);
    } catch (e) {
      return (failure: AuthFailure(e.toString()), value: null);
    }
  }

  Future<({Failure? failure, void value})> sendPhoneOtp(String phone) async {
    try {
      await _supabase.auth.signInWithOtp(phone: phone);
      return (failure: null, value: null);
    } catch (e) {
      return (failure: AuthFailure(e.toString()), value: null);
    }
  }

  Future<({Failure? failure, TherapistSession? value})> verifyOtp({
    required String contact,
    required String otp,
    required bool isEmail,
  }) async {
    try {
      final response = await _supabase.auth.verifyOTP(
        email: isEmail ? contact : null,
        phone: isEmail ? null : contact,
        token: otp,
        type: isEmail ? OtpType.email : OtpType.sms,
      );
      final token = response.session?.accessToken;
      if (token == null) {
        return (failure: const AuthFailure('OTP verification failed'), value: null);
      }
      return _callAuthCallback(token);
    } catch (e) {
      return (failure: AuthFailure(e.toString()), value: null);
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// Calls the backend AuthCallback RPC with the Supabase JWT.
  Future<({Failure? failure, TherapistSession? value})> _callAuthCallback(
      String token) async {
    // TODO: use generated gRPC stub once proto is compiled for mobile
    // final stub = TherapistServiceClient(_grpc.channel);
    // final res = await stub.authCallback(AuthCallbackRequest(supabaseToken: token));
    // return (failure: null, value: TherapistSession(therapistId: res.therapistId, status: res.status));

    // Placeholder until proto is wired up:
    return (
      failure: null,
      value: TherapistSession(therapistId: 'stub-id', status: 'needs_onboarding'),
    );
  }
}
