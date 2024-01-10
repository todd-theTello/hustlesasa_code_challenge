import 'package:dio/dio.dart';

import 'endpoints.dart';
import 'interceptors/authorization_interceptor.dart';
import 'interceptors/logger_interceptor.dart';

/// dio weather client
class DioClient {
  /// weather client constructor
  const DioClient();

  /// static dio instance
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: Endpoints.connectionTimeout,
      receiveTimeout: Endpoints.receiveTimeout,
    ),
  )..interceptors.addAll([NetworkInterceptor(), LoggerInterceptor()]);

  /// make api call
  Future<Response<dynamic>> call({
    required String path,
    required RequestMethod requestMethod,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      return switch (requestMethod) {
        RequestMethod.get => await dio.get(path, queryParameters: queryParams),
        RequestMethod.post => await dio.post(path, data: data, queryParameters: queryParams),
        RequestMethod.put => await dio.put(path, data: data, queryParameters: queryParams),
        RequestMethod.patch => await dio.patch(path, data: data, queryParameters: queryParams),
        RequestMethod.delete => await dio.delete(path, data: data, queryParameters: queryParams),
      };
    } on DioException catch (error, stackTrace) {
      return Future.error(error, stackTrace);
    }
  }
}

/// specify the request method of the api call
enum RequestMethod {
  ///
  get,

  ///
  post,

  ///
  put,

  ///
  patch,

  ///
  delete,
}
