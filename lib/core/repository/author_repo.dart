import 'package:dio/dio.dart';

import '../api/api_service.dart';
import '../models/user.dart';
import '../../core/utils/constants.dart';
import 'base_repo.dart';

class AuthorRepository extends BaseRepository<UserModel> {
  AuthorRepository(ApiService apiService) : super(apiService);

  @override
  String get endpoint => AppConstants.baseUrl + AppConstants.authorsEndpoint;

  @override
  UserModel fromJson(Map<String, dynamic> json) => UserModel.fromJson(json);

  Future<List<UserModel>> searchAuthors(String query) async {
    try {
      final response = await apiService.get('$endpoint/search?query=$query');
      final List data = response.data['data'] ?? [];
      return data.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      throw _handleDioError(e);
      return _handleDioError(e);
    }
  }

  Future<void> toggleVisibility(String id, bool visible) async {
    await update(id, {'visible': visible});
  }

  Future<UserModel> getCurrentUser(String id) async {
    try {
      final response = await apiService.get('$endpoint/$id');
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw _handleDioError(e);
      return _handleDioError(e);
    }
  }

  Future<UserModel> updateCurrentUser(
      String id, Map<String, dynamic> data) async {
    try {
      final response = await apiService.put('$endpoint/$id', data);
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw _handleDioError(e);
      return _handleDioError(e);
      // rethrow;
    }
  }

  Future<UserModel> createAuthor(Map<String, dynamic> data) async {
    try {
      final response = await apiService.post(endpoint, data);
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  _handleDioError(e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection Timeout';
      case DioExceptionType.badResponse:
        return '${e.response?.data}';
      case DioExceptionType.cancel:
        return 'Request Cancelled';
      case DioExceptionType.unknown:
      default:
        return 'Unexpected Error: ${e.message}';
    }
  }
}
