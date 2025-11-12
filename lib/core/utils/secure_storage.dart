import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Handles all secure storage interactions (tokens, preferences, etc.)
class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static const _keyAuthToken = 'auth_token';
  static const _keyIsAuthor = 'is_author';

  /// Save the JWT token securely
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _keyAuthToken, value: token);
  }

  /// Retrieve saved token
  static Future<String?> getToken() async {
    return await _storage.read(key: _keyAuthToken);
  }

  /// Delete the token (used for logout)
  static Future<void> deleteToken() async {
    await _storage.delete(key: _keyAuthToken);
  }

  /// Save author status (true/false)
  Future<void> saveAuthorStatus(bool isAuthor) async {
    await _storage.write(key: _keyIsAuthor, value: isAuthor.toString());
  }

  /// Retrieve author status
  Future<bool> getAuthorStatus() async {
    final value = await _storage.read(key: _keyIsAuthor);
    return value == 'true';
  }

  /// Clear all stored data (logout or reset)
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
