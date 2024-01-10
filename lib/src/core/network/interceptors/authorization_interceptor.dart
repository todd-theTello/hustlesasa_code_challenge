import 'dart:async';

import 'package:dio/dio.dart';

class NetworkInterceptor extends QueuedInterceptorsWrapper {
  /// Interceptor on network response
  @override
  Future<FutureOr<dynamic>> onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) async {
    /// perform actions when a response is available without errors
    /// if (response.statusCode! >= 200 && response.statusCode! < 400) {
    ///   response.statusCode = 200;
    /// }
    super.onResponse(response, handler);
  }

  /// Authorization interceptor on network request
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    /// Token checks normally happen here

    ///  final String? bearerToken = await SecureStorage.readFromStorage(key: 'access_token');
    ///   final String? refreshToken = await SecureStorage.readFromStorage(key: 'refresh_token');
    /// Logout user if refresh token expires
    /// if (JwtDecoder.isExpired(refreshToken ?? '')) {
    ///   await globalWidgetRef?.read(authenticationProvider.notifier).signOut();
    ///   return handler.next(options);
    /// }

    /// check if access token is expired
    /// if (JwtDecoder.isExpired(bearerToken ?? '')) {
    ///   /// refresh the access token if the token is expired
    ///   final String? newToken = await RefreshTokenRepository.refreshToken();
    ///   options.headers.addAll({
    ///     'Authorization': '$newToken',
    ///     'Content-Type': 'application/json',
    ///   });
    /// } else {
    ///   options.headers.addAll({
    ///     'Authorization': '$bearerToken',
    ///     'Content-Type': 'application/json',
    ///   });
    /// }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    /// perform actions on user logout
    /// like login a user out when a certain error code is provided
    super.onError(err, handler);
  }
}
