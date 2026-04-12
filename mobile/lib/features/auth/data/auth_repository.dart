import 'package:grpc/service_api.dart';
import 'package:therapist/core/error/failures.dart';
import 'package:therapist/core/error/result.dart';
import 'package:therapist/core/network/grpc_client.dart';
import 'package:therapist/core/proto/therapist.pbgrpc.dart';
import 'package:therapist/core/session/session_store.dart';

const _kRpcTimeout = Duration(seconds: 15);

class TherapistSession {
  const TherapistSession({
    required this.status,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    this.accountType = 'therapist',
    this.therapistId = '',
    this.userId = '',
  });

  final String therapistId;
  final String userId;
  final String accountType;  // 'therapist' | 'user'
  final String status;
  final String accessToken;
  final String refreshToken;
  final int    expiresAt;

  factory TherapistSession.fromStored(StoredSession s) => TherapistSession(
        accountType:  s.accountType,
        therapistId:  s.isTherapist ? s.entityId : '',
        userId:       s.isUser      ? s.entityId : '',
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

    // Access token expired — try silent refresh based on account type.
    if (stored.isUser) {
      return _silentUserRefresh(stored.refreshToken);
    }
    return _silentRefresh(stored.refreshToken);
  }

  Future<Result<TherapistSession>> _silentRefresh(String refreshToken) async {
    try {
      final res = await _stub.refreshSession(
        RefreshSessionRequest()..refreshToken = refreshToken,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      await _store.rotateTokens(
        accessToken:  res.accessToken,
        refreshToken: res.refreshToken,
        expiresAt:    res.expiresAt.toInt(),
        status:       res.status,
      );
      return Result.success(TherapistSession(
        accountType:  'therapist',
        therapistId:  res.therapistId,
        status:       res.status,
        accessToken:  res.accessToken,
        refreshToken: res.refreshToken,
        expiresAt:    res.expiresAt.toInt(),
      ));
    } catch (_) {
      await _store.clear();
      return Result.error(const AuthFailure('Session expired. Please log in again.'));
    }
  }

  Future<Result<TherapistSession>> _silentUserRefresh(String refreshToken) async {
    try {
      final res = await _stub.userRefreshSession(
        UserRefreshSessionRequest()..refreshToken = refreshToken,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      await _store.rotateTokens(
        accessToken:  res.accessToken,
        refreshToken: res.refreshToken,
        expiresAt:    res.expiresAt.toInt(),
        status:       res.status,
      );
      return Result.success(TherapistSession(
        accountType:  'user',
        userId:       res.userId,
        status:       res.status,
        accessToken:  res.accessToken,
        refreshToken: res.refreshToken,
        expiresAt:    res.expiresAt.toInt(),
      ));
    } catch (_) {
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
    String accountType = 'therapist',
  }) async {
    if (otp != '123456') {
      return Result.error(const AuthFailure('Invalid OTP. Use 123456 for testing.'));
    }
    if (accountType == 'user') {
      return _userAuthCallback('dev:$contact');
    }
    return _authCallback('dev:$contact');
  }

  Future<Result<TherapistSession>> _authCallback(String token) async {
    try {
      final res = await _stub.authCallback(
        AuthCallbackRequest()..supabaseToken = token,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      final session = TherapistSession(
        accountType:  'therapist',
        therapistId:  res.therapistId,
        status:       res.status,
        accessToken:  res.accessToken,
        refreshToken: res.refreshToken,
        expiresAt:    res.expiresAt.toInt(),
      );
      await _store.save(StoredSession(
        accountType:  'therapist',
        entityId:     res.therapistId,
        status:       res.status,
        accessToken:  session.accessToken,
        refreshToken: session.refreshToken,
        expiresAt:    session.expiresAt,
      ));
      return Result.success(session);
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  Future<Result<TherapistSession>> _userAuthCallback(String token) async {
    try {
      final res = await _stub.userAuthCallback(
        UserAuthCallbackRequest()..supabaseToken = token,
        options: CallOptions(timeout: _kRpcTimeout),
      );
      final session = TherapistSession(
        accountType:  'user',
        userId:       res.userId,
        status:       res.status,
        accessToken:  res.accessToken,
        refreshToken: res.refreshToken,
        expiresAt:    res.expiresAt.toInt(),
      );
      await _store.save(StoredSession(
        accountType:  'user',
        entityId:     res.userId,
        status:       res.status,
        accessToken:  session.accessToken,
        refreshToken: session.refreshToken,
        expiresAt:    session.expiresAt,
      ));
      return Result.success(session);
    } catch (e) {
      return Result.error(ServerFailure(e.toString()));
    }
  }

  Future<void> signOut(String refreshToken, {String accountType = 'therapist'}) async {
    try {
      if (accountType == 'user') {
        await _stub.userLogout(
          UserLogoutRequest()..refreshToken = refreshToken,
          options: CallOptions(timeout: _kRpcTimeout),
        );
      } else {
        await _stub.logout(
          LogoutRequest()..refreshToken = refreshToken,
          options: CallOptions(timeout: _kRpcTimeout),
        );
      }
    } catch (_) {
      // Best-effort — always clear local storage
    }
    await _store.clear();
  }
}
