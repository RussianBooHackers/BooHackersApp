library api;

import 'dart:convert';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:boohack/blocs/blocs.dart';
import 'package:boohack/utils/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/serializers.dart';
import '../models/models.dart';

part './bar.dart';

/// base Api class
/// Before using Api you must to:
/// initialize [Api] using [Api.init()]
/// flill [baseUrl] in Api class
///
/// Then you can use Api like: [Api.yourAwesomeMethod()]
///
/// {@category Network}
_parseAndDecode(String response) {
  return jsonDecode(response);
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class LogInterceptor extends Interceptor {
  LogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
    this.logSize = 2048,
  });

  bool request;
  bool requestHeader;
  bool requestBody;
  bool responseBody;
  bool responseHeader;
  bool error;
  final logSize;

  @override
  onRequest(RequestOptions options) async {
    print("*** Request ***");
    print("${options.method} ${options.uri} ?${options.queryParameters} B${options.data} H${options.headers}");
  }

  @override
  onError(DioError err) async {
    if (error) {
      print('*** DioError ***:');
      print(err);
      if (err.response != null) {
        printAll(err.response.toString());
      }
    }
  }

  @override
  onResponse(Response response) async {
    print("*** Response ***");
    printAll(response.toString());
  }

  printAll(msg) {
    msg.toString().split("\n").forEach(_printAll);
  }

  _printAll(String msg) {
    int groups = (msg.length / logSize).ceil();
    for (int i = 0; i < groups; ++i) {
      print((i > 0 ? '<<Log follows the previous line: ' : '') +
          msg.substring(i * logSize, math.min<int>(i * logSize + logSize, msg.length)));
    }
  }
}

class Api {
  static Dio dio;

  static void init([String authToken]) {
    BaseOptions options = new BaseOptions(
        baseUrl: '${Config.apiUrl}',
        connectTimeout: 10000,
        receiveTimeout: 10000,
        headers: {'authorization': Config.token});
    dio = new Dio(options);
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(InterceptorsWrapper(onError: (DioError error) {
      if (error.response == null)
        NotificationBloc.getInstance()
            .dispatch(NotificationEvent("Отсутствует соединение с сервером. Проверьте подключение"));
      else if (error.response.statusCode >= 400) throw Error();
    }));

    (dio.transformer as DefaultTransformer).jsonDecodeCallback = _parseJson;
  }
}
