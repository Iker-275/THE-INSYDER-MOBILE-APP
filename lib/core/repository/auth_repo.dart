import 'package:insyder/core/api/api_service.dart';

import '../utils/secure_storage.dart';

/// Handles authentication API logic
class AuthRepository {
  final ApiService _apiService;
  final SecureStorageService _storageService;

  AuthRepository(this._apiService, this._storageService);

  /// Login user
  Future<bool> login(String email, String password) async {
    final response = await _apiService.post(
      '/auth/login',
      {'email': email, 'password': password},
    );

    var res = response.data;

    if (res['token'] != null) {
      await _storageService.saveToken(res['token']);

      final isAuthor = res['author'] == true;
      await _storageService.saveAuthorStatus(isAuthor);

      return true;
    }

    return false;
  }

  /// Register new user
  Future<bool> register(Map<String, dynamic> userData) async {
    final response = await _apiService.post('/auth/register', userData);
    var res = response.data;

    return res['success'] == true;
  }

  /// Logout
  Future<void> logout() async {
    await _storageService.clearAll();
  }

  /// Get whether the user is an author
  Future<bool> isAuthor() async {
    return await _storageService.getAuthorStatus();
  }

  /// Get token (for APIs that need it)
  Future<String?> getToken() async {
    return await _storageService.getToken();
  }
}
