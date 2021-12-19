import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/constant/util/app_util.dart';
import 'package:kod_sozluk_mobile/model/base/network_error.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpClient {
  late Dio client;

  HttpClient() {
    client = getDioWithInterceptors();
    client.interceptors.addAll([PrettyDioLogger(requestHeader: true, requestBody: true)]);
  }

  Dio createDio() {
    return Dio(
      BaseOptions(
        connectTimeout: 60000, // 60sec
        receiveTimeout: 60000, // 60sec
      ),
    );
  }

  Dio getDioWithInterceptors() {
    final Dio dio = createDio();
    return dio
      ..interceptors.add(
        InterceptorsWrapper(
          onResponse: (Response response, ResponseInterceptorHandler handler) => responseInterceptor(response, handler),
          onRequest: (RequestOptions options, RequestInterceptorHandler handler) =>
              requestInterceptor(options, handler),
          onError: (DioError dioError, ErrorInterceptorHandler handler) => onError(dioError, handler),
        ),
      );
  }

  dynamic onError(DioError dioError, ErrorInterceptorHandler handler) {
    log("${dioError.response}");

    if (dioError.type == DioErrorType.connectTimeout) {
      final NetworkError networkError = NetworkError(
        status: LocaleKeys.connection_timeout.locale,
        detail: LocaleKeys.connection_timeout_please_try_again.locale,
      );

      return handler.next(networkError);
    }

    if (dioError.response?.data != null) {
      final Response response = dioError.response!;
      final NetworkError errorHandler = NetworkError.fromJson(response.data as Map<String, dynamic>);

      return handler.next(errorHandler);
    }

    return handler.next(dioError);
  }

  dynamic requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    final String? authorizationToken = AppUtil.authorizationToken;

    options.headers.addAll({
      "Content-Encoding": "gzip",
      "Cache-Control": "no-cache",
      "Accept-Encoding": "gzip, deflate, br",
      "Content-Type": "application/json",
      "X-Locale-Info": AppConstants.localeKey
    });

    if (authorizationToken != null && authorizationToken.isNotEmpty) {
      options.headers.addAll({"Authorization": "Bearer $authorizationToken"});
    }

    return handler.next(options);
  }

  dynamic responseInterceptor(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }
}
