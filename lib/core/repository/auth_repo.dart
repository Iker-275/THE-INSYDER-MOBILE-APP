import 'package:dio/dio.dart';
import 'package:insyder/core/api/api_service.dart';
import 'package:insyder/core/utils/constants.dart';

import '../utils/secure_storage.dart';

/// Handles authentication API logic
class AuthRepository {
  final ApiService _apiService;
  final SecureStorageService _storageService;

  AuthRepository(this._apiService, this._storageService);

  /// Login user
  Future<bool> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        AppConstants.baseUrl + AppConstants.signin,
        {'email': email, 'password': password},
      );

      var res = response.data;
      print("res :r$res");

      if (res['token'] != null) {
        await SecureStorageService.saveToken(res['token']);

        final isAuthor = res['author'] == true;
        await _storageService.saveAuthorStatus(isAuthor);

        return true;
      }
    } catch (e) {
      print("error");
      throw _handleDioError(e);
    }
    return false;
  }

  /// Register new user
  Future<bool> register(Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.post(
          AppConstants.baseUrl + AppConstants.signup, userData);
      var res = response.data;
      return res['success'] == true;
    } catch (e) {
      throw _handleDioError(e);
    }
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
    return await SecureStorageService.getToken();
  }

  //Exception
  _handleDioError(e) {
    var email = e.response?.data['errors']['email'] ?? "";
    var password = e.response?.data['errors']['password'] ?? "";

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection Timeout';
      case DioExceptionType.badResponse:
        return email + " " + password;
      case DioExceptionType.cancel:
        return 'Request Cancelled';
      case DioExceptionType.unknown:
      default:
        return 'Unexpected Error: ${e.message}';
    }
  }
}
