import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor{
  final String token;

  AppInterceptor(this.token);
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}

