import 'package:dio/dio.dart';

import '../api/api_service.dart';
import '../utils/constants.dart';

abstract class BaseRepository<T> {
  final ApiService apiService;

  BaseRepository(this.apiService);

  String get endpoint;

  T fromJson(Map<String, dynamic> json);

  Future<List<T>> getAll(
      {int page = 1, int limit = AppConstants.defaultPageSize}) async {
    try {
      final response =
          await apiService.get('$endpoint?page=$page&limit=$limit');
      final List data =
          response.data is List ? response.data : response.data['data'];
      return data.map((e) => fromJson(e)).toList().cast<T>();
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<T> getById(String id) async {
    try {
      final response = await apiService.get('$endpoint/$id');
      return fromJson(response.data);
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<T> create(Map<String, dynamic> data) async {
    try {
      final response = await apiService.post(endpoint, data);
      return fromJson(response.data);
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<T> update(String id, Map<String, dynamic> data) async {
    try {
      final response = await apiService.put('$endpoint/$id', data);
      return fromJson(response.data);
    } catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await apiService.delete('$endpoint/$id');
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
