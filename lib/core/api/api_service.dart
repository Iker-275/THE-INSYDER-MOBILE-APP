import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/dio_client.dart';

class ApiService {
  final Dio _dio = DioClient.dio;

  Future<Response> get(String endpoint, {Map<String, dynamic>? query}) async {
    return await _dio.get(endpoint, queryParameters: query);
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    return await _dio.post(endpoint, data: data);
  }

  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    return await _dio.put(endpoint, data: data);
  }

  Future<Response> delete(String endpoint) async {
    return await _dio.delete(endpoint);
  }
}
