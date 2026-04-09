import 'package:therapist/core/error/failures.dart';
import 'package:therapist/core/error/result.dart';
import 'package:therapist/core/network/grpc_client.dart';
import 'package:therapist/core/proto/therapist.pbgrpc.dart';

class TherapistSession {
  const TherapistSession({required this.therapistId, required this.status});
  final String therapistId;
  final String status; // needs_onboarding | pending | verified | rejected
}

class AuthRepository {
  AuthRepository({required GrpcClient grpc}) : _grpc = grpc;

  final GrpcClient _grpc;

  TherapistServiceClient get _stub => TherapistServiceClient(_grpc.channel);

  Future<Result<TherapistSession>> getCurrentSession() async {
    // TODO: restore real session check after Supabase auth is re-enabled
    return Result.error(const AuthFailure('No active session'));
  }

  Future<Result<TherapistSession>> signInWithGoogle() async {
    // TODO: wire Supabase Google OAuth
    return Result.error(const AuthFailure('Google sign-in not available yet'));
  }

  Future<Result<void>> sendEmailOtp(String email) async {
    // TODO: call Supabase signInWithOtp when re-enabled
    return Result.success(null);
  }

  Future<Result<TherapistSession>> verifyOtp({
    required String contact,
    required String otp,
    required bool isEmail,
  }) async {
    if (otp != '123456') {
      return Result.error(const AuthFailure('Invalid OTP. Use 123456 for testing.'));
    }
    // Dev bypass: pass "dev:<email>" token — accepted by backend in non-prod mode
    return callAuthCallback('dev:$contact');
  }

  Future<void> signOut() async {
    // TODO: Supabase sign out when re-enabled
  }

  Future<Result<TherapistSession>> callAuthCallback(String token) async {
    try {
      final res = await _stub.authCallback(
        AuthCallbackRequest()..supabaseToken = token,
      );
      return Result.success(
        TherapistSession(therapistId: res.therapistId, status: res.status),
      );
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }
}
