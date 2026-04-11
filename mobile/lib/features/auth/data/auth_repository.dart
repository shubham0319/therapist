import 'package:therapist/core/error/failures.dart';
import 'package:therapist/core/error/result.dart';
import 'package:therapist/core/network/grpc_client.dart';
import 'package:therapist/core/proto/therapist.pbgrpc.dart';
import 'package:therapist/core/session/session_store.dart';

class TherapistSession {
  const TherapistSession({
    required this.therapistId,
    required this.status,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  final String therapistId;
  final String status;       // needs_onboarding | pending | verified | rejected
  final String accessToken;
  final String refreshToken;
  final int    expiresAt;    // unix timestamp

  factory TherapistSession.fromStored(StoredSession s) => TherapistSession(
        therapistId:  s.therapistId,
        status:       s.status,
        accessToken:  s.accessToken,
        refreshToken: s.refreshToken,
        expiresAt:    s.expiresAt,
      );
}

class AuthRepository {
  AuthRepository({required GrpcClient grpc, required SessionStore store})
      : _grpc = grpc,
        _store = store;

  final GrpcClient _grpc;
  final SessionStore _store;

  TherapistServiceClient get _stub => TherapistServiceClient(_grpc.channel);

  // ── Session persistence ───────────────────────────────────────────────────

  /// Load session from secure storage; auto-refresh if access token is expired.
  Future<Result<TherapistSession>> getCurrentSession() async {
    final stored = await _store.load();
    if (stored == null) return Result.error(const AuthFailure('No active session'));

    if (!stored.isAccessTokenExpired) {
      return Result.success(TherapistSession.fromStored(stored));
    }

    // Access token expired — try silent refresh
    return _silentRefresh(stored.refreshToken);
  }

  Future<Result<TherapistSession>> _silentRefresh(String refreshToken) async {
    try {
      final res = await _stub.refreshSession(
        RefreshSessionRequest()..refreshToken = refreshToken,
      );
      await _store.rotateTokens(
        accessToken:  res.accessToken,
        refreshToken: res.refreshToken,
        expiresAt:    res.expiresAt.toInt(),
        status:       res.status,
      );
      return Result.success(TherapistSession(
        therapistId:  res.therapistId,
        status:       res.status,
        accessToken:  res.accessToken,
        refreshToken: res.refreshToken,
        expiresAt:    res.expiresAt.toInt(),
      ));
    } catch (_) {
      // Refresh token expired or invalid — force re-login
      await _store.clear();
      return Result.error(const AuthFailure('Session expired. Please log in again.'));
    }
  }

  // ── Auth actions ──────────────────────────────────────────────────────────

  Future<Result<void>> sendEmailOtp(String email) async {
    // TODO: call Supabase signInWithOtp when re-enabled
    return Result.success(null);
  }

  Future<Result<TherapistSession>> signInWithGoogle() async {
    // TODO: wire Supabase Google OAuth
    return Result.error(const AuthFailure('Google sign-in not available yet'));
  }

  Future<Result<TherapistSession>> verifyOtp({
    required String contact,
    required String otp,
    required bool isEmail,
  }) async {
    if (otp != '123456') {
      return Result.error(const AuthFailure('Invalid OTP. Use 123456 for testing.'));
    }
    return _authCallback('dev:$contact');
  }

  Future<Result<TherapistSession>> _authCallback(String token) async {
    try {
      final res = await _stub.authCallback(
        AuthCallbackRequest()..supabaseToken = token,
      );
      final session = TherapistSession(
        therapistId:  res.therapistId,
        status:       res.status,
        accessToken:  res.accessToken,
        refreshToken: res.refreshToken,
        expiresAt:    res.expiresAt.toInt(),
      );
      await _store.save(StoredSession(
        therapistId:  session.therapistId,
        status:       session.status,
        accessToken:  session.accessToken,
        refreshToken: session.refreshToken,
        expiresAt:    session.expiresAt,
      ));
      return Result.success(session);
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  Future<void> signOut(String refreshToken) async {
    try {
      await _stub.logout(LogoutRequest()..refreshToken = refreshToken);
    } catch (_) {
      // Best-effort — always clear local storage
    }
    await _store.clear();
  }
}
