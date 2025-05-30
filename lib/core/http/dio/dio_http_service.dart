import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pokemon_app/core/design/widgets/error_widget.dart';
import 'package:pokemon_app/core/http/dio/dio_interceptors.dart';
import 'package:pokemon_app/core/http/http_service.dart';

class DioHttpService implements HttpService {
  late Dio _client;

  DioHttpService({
    required this.baseUrl,
    this.timeout = 60,
    InterceptorsWrapper? interceptor,
  }) {
    _client = Dio();
    _client.interceptors.add(interceptor ?? DioInterceptor());
    _client.options.baseUrl = baseUrl;
    _client.options.connectTimeout = Duration(seconds: timeout);
    _client.options.receiveTimeout = Duration(seconds: timeout);

    if (kIsWeb) {
      return;
    }

    (_client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      return client;
    };
  }

  @override
  String baseUrl;

  @override
  int timeout;

  @override
  Future delete({required String path, data, queryParams, Function? onError}) async {
    try {
      var response = await _client.delete(
        path,
        data: data,
        queryParameters: queryParams,
      );
      return response.data;
    } catch (e, stack) {
      await handleException(e, onError, stack);
    }
  }

  @override
  Future get({required String path, data, queryParams, Function? onError}) async {
    try {
      var response = await _client.get(
        path,
        data: data,
        queryParameters: queryParams,
      );
      return response.data;
    } catch (e, stack) {
      await handleException(e, onError, stack);
    }
  }

  @override
  Future post({required String path, data, queryParams, Function? onError}) async {
    try {
      var response = await _client.post(
        path,
        data: data,
        queryParameters: queryParams,
      );
      return response.data;
    } catch (e, stack) {
      await handleException(e, onError, stack);
    }
  }

  @override
  Future put({
    required String path,
    data,
    queryParams,
    Function? onError,
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await _client.put(
        path,
        data: data,
        queryParameters: queryParams,
        options: headers != null
            ? Options(
                headers: headers,
              )
            : null,
      );
      return response.data;
    } catch (e, stack) {
      await handleException(e, onError, stack);
    }
  }

  @override
  Future patch({required String path, data, queryParams, Function? onError}) async {
    try {
      var response = await _client.patch(
        path,
        data: data,
        queryParameters: queryParams,
      );
      return response.data;
    } catch (e, stack) {
      await handleException(e, onError, stack);
    }
  }

  @override
  updateHeaders({headers}) {
    _client.options.headers = headers;
  }
}
