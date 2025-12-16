import 'package:dio/dio.dart';
import 'package:team_7/core/networking/api_constant.dart';
import 'package:team_7/core/networking/api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = ApiConstants.baseUrl;
  }

  @override
  Future<dynamic> get({
    required String path,
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.get(
      path,
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  @override
  Future<dynamic> post({
    required String path,
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.post(
      path,
      data: body,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  @override
  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.put(
      path,
      data: body,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  @override
  Future<dynamic> delete({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.delete(
      path,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  @override
  Future<dynamic> patch({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.patch(
      path,
      data: body,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}



