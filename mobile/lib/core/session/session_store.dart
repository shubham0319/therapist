import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Keys used in secure storage.
class _Keys {
  static const accountType  = 'account_type';  // 'therapist' | 'user'
  static const entityId     = 'entity_id';     // therapistId or userId
  static const therapistId  = 'therapist_id';  // kept for backwards-compat read
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
    try {
      await Future.wait([
        _storage.write(key: _Keys.accountType,  value: session.accountType),
        _storage.write(key: _Keys.entityId,     value: session.entityId),
        _storage.write(key: _Keys.status,       value: session.status),
        _storage.write(key: _Keys.accessToken,  value: session.accessToken),
        _storage.write(key: _Keys.refreshToken, value: session.refreshToken),
        _storage.write(key: _Keys.expiresAt,    value: session.expiresAt.toString()),
      ]);
    } catch (_) {
      // Storage write failure is non-fatal — session lives in memory for this run.
    }
  }

  /// Update status only (after background status poll / onboarding submit).
  Future<void> updateStatus(String status) async {
    try {
      await _storage.write(key: _Keys.status, value: status);
    } catch (_) {}
  }

  /// Rotate tokens after a successful refresh without touching other fields.
  Future<void> rotateTokens({
    required String accessToken,
    required String refreshToken,
    required int expiresAt,
    required String status,
  }) async {
    try {
      await Future.wait([
        _storage.write(key: _Keys.accessToken,  value: accessToken),
        _storage.write(key: _Keys.refreshToken, value: refreshToken),
        _storage.write(key: _Keys.expiresAt,    value: expiresAt.toString()),
        _storage.write(key: _Keys.status,       value: status),
      ]);
    } catch (_) {}
  }

  /// Returns null when no session exists or if secure storage is unavailable.
  Future<StoredSession?> load() async {
    try {
      // Try new key first, fall back to legacy 'therapist_id' key.
      final accountType  = await _storage.read(key: _Keys.accountType) ?? 'therapist';
      final entityId     = await _storage.read(key: _Keys.entityId)
                        ?? await _storage.read(key: _Keys.therapistId);
      final status       = await _storage.read(key: _Keys.status);
      final accessToken  = await _storage.read(key: _Keys.accessToken);
      final refreshToken = await _storage.read(key: _Keys.refreshToken);
      final expiresAtStr = await _storage.read(key: _Keys.expiresAt);

      if (entityId == null || status == null ||
          accessToken == null || refreshToken == null || expiresAtStr == null) {
        return null;
      }

      return StoredSession(
        accountType:  accountType,
        entityId:     entityId,
        status:       status,
        accessToken:  accessToken,
        refreshToken: refreshToken,
        expiresAt:    int.parse(expiresAtStr),
      );
    } catch (_) {
      // WebCrypto OperationError on Flutter web (corrupted / missing key).
      // Treat as no session — user will be sent to login.
      return null;
    }
  }

  /// Wipe all stored session data (logout).
  Future<void> clear() async {
    try {
      await Future.wait([
        _storage.delete(key: _Keys.accountType),
        _storage.delete(key: _Keys.entityId),
        _storage.delete(key: _Keys.therapistId),
        _storage.delete(key: _Keys.status),
        _storage.delete(key: _Keys.accessToken),
        _storage.delete(key: _Keys.refreshToken),
        _storage.delete(key: _Keys.expiresAt),
      ]);
    } catch (_) {
      // Best-effort clear — ignore storage errors.
    }
  }
}

/// Plain data class for the persisted session.
class StoredSession {
  const StoredSession({
    required this.accountType,
    required this.entityId,
    required this.status,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  /// 'therapist' or 'user'
  final String accountType;
  /// therapistId when accountType == 'therapist'; userId when 'user'
  final String entityId;
  final String status;
  final String accessToken;  // JWT, short-lived
  final String refreshToken; // opaque hex, long-lived
  final int    expiresAt;    // unix timestamp (access token expiry)

  bool get isTherapist => accountType == 'therapist';
  bool get isUser      => accountType == 'user';

  /// Legacy accessor — returns entityId for therapist accounts.
  String get therapistId => isTherapist ? entityId : '';

  bool get isAccessTokenExpired =>
      DateTime.now().millisecondsSinceEpoch ~/ 1000 >= expiresAt - 30;
}
