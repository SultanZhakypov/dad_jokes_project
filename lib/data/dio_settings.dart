import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioSettings {
  DioSettings() {
    setup();
  }
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://icanhazdadjoke.com/',
      contentType: 'application/json',
      headers: {'Accept': 'application/json'},
    ),
  );

  void setup() async {
    final interceptors = dio.interceptors;
    interceptors.clear();

    final headerInterceptor =
        QueuedInterceptorsWrapper(onResponse: (e, handler) {
      return handler.next(e);
    }, onError: (DioError err, handler) {
      handler.next(err);
    }, onRequest: (options, handler) {
      return handler.next(options);
    });
    final logInterceptor = LogInterceptor(
        requestHeader: true,
        error: true,
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true);

    interceptors.addAll([if (kDebugMode) headerInterceptor, logInterceptor]);
  }
}
