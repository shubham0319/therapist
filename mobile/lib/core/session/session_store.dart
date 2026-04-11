import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Keys used in secure storage.
class _Keys {
  static const therapistId  = 'therapist_id';
  static const status       = 'therapist_status';
  static const accessToken  = 'access_token';
  static const refreshToken = 'refresh_token';
  static const expiresAt    = 'expires_at'; // stored as unix timestamp string
}

/// Persists and retrieves the therapist session using device secure storage
/// (Keychain on iOS, Keystore-backed EncryptedSharedPreferences on Android).
class SessionStore {
  const SessionStore(this._storage);

  final FlutterSecureStorage _storage;

  /// Persist all session fields atomically.
  Future<void> save(StoredSession session) async {
    await Future.wait([
      _storage.write(key: _Keys.therapistId,  value: session.therapistId),
      _storage.write(key: _Keys.status,       value: session.status),
      _storage.write(key: _Keys.accessToken,  value: session.accessToken),
      _storage.write(key: _Keys.refreshToken, value: session.refreshToken),
      _storage.write(key: _Keys.expiresAt,    value: session.expiresAt.toString()),
    ]);
  }

  /// Update status only (after background status poll / onboarding submit).
  Future<void> updateStatus(String status) async {
    await _storage.write(key: _Keys.status, value: status);
  }

  /// Rotate tokens after a successful refresh without touching other fields.
  Future<void> rotateTokens({
    required String accessToken,
    required String refreshToken,
    required int expiresAt,
    required String status,
  }) async {
    await Future.wait([
      _storage.write(key: _Keys.accessToken,  value: accessToken),
      _storage.write(key: _Keys.refreshToken, value: refreshToken),
      _storage.write(key: _Keys.expiresAt,    value: expiresAt.toString()),
      _storage.write(key: _Keys.status,       value: status),
    ]);
  }

  /// Returns null when no session exists.
  Future<StoredSession?> load() async {
    final therapistId  = await _storage.read(key: _Keys.therapistId);
    final status       = await _storage.read(key: _Keys.status);
    final accessToken  = await _storage.read(key: _Keys.accessToken);
    final refreshToken = await _storage.read(key: _Keys.refreshToken);
    final expiresAtStr = await _storage.read(key: _Keys.expiresAt);

    if (therapistId == null || status == null ||
        accessToken == null || refreshToken == null || expiresAtStr == null) {
      return null;
    }

    return StoredSession(
      therapistId:  therapistId,
      status:       status,
      accessToken:  accessToken,
      refreshToken: refreshToken,
      expiresAt:    int.parse(expiresAtStr),
    );
  }

  /// Wipe all stored session data (logout).
  Future<void> clear() async {
    await Future.wait([
      _storage.delete(key: _Keys.therapistId),
      _storage.delete(key: _Keys.status),
      _storage.delete(key: _Keys.accessToken),
      _storage.delete(key: _Keys.refreshToken),
      _storage.delete(key: _Keys.expiresAt),
    ]);
  }
}

/// Plain data class for the persisted session.
class StoredSession {
  const StoredSession({
    required this.therapistId,
    required this.status,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  final String therapistId;
  final String status;       // "needs_onboarding" | "pending" | "verified" | "rejected"
  final String accessToken;  // JWT, short-lived
  final String refreshToken; // opaque hex, long-lived
  final int    expiresAt;    // unix timestamp (access token expiry)

  bool get isAccessTokenExpired =>
      DateTime.now().millisecondsSinceEpoch ~/ 1000 >= expiresAt - 30;
      // 30-second buffer to proactively refresh before actual expiry
}
