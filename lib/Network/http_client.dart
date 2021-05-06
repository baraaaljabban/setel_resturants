import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as http;
import 'package:setel/Network/server_strings.dart';
/// "[MHttpClient]" [HTTP] wraper class
/// this class is cover up our need in the futuer for example:
/// (1) send [headers] with every single request so
/// (2) [print] our respons every time with [params] and etc..
class MHttpClient {
  final http.Client client;
  MHttpClient({this.client});

  /// [GET] with a givin [path] as String
  /// [extraHeders] if you need it.
  Future<http.Response> get({
    String path = "",
    Map<String, String> extraHeders,
  }) async {
    printWrapped('get Path: $path');
    final response = await client.get(
      getBaseURL() + path,
      headers: getHeaders(extraHeaders: extraHeders),
    );
    printWrapped("get response : \n" + utf8.decode(response.bodyBytes));
    return response;
  }

  /// [POST] with a givin [body] as String and [path] as String
  /// [extraHeders] that servers sometimes need it as [API_KEY] etc...
  Future<http.Response> post({
    String body = "",
    String path = "",
    Map<String, String> extraHeders,
  }) async {
    printWrapped('sended body: \n');
    printWrapped(' ${json.decode(body)}');
    final response = await client.post(
      getBaseURL() + path,
      body: body,
      headers: getHeaders(extraHeaders: extraHeders),
    );
    printWrapped("post response : \n" + utf8.decode(response.bodyBytes));
    return response;
  }

  /// [PUT] with a givin [body] as String and [path] as String
  Future<http.Response> put({String body = "", String path = ""}) async {
    printWrapped('put body: \n ${json.decode(body)}');
    final response = await client.put(
      getBaseURL() + path,
      body: body,
      headers: getHeaders(),
    );
    printWrapped(utf8.decode(response.bodyBytes));
    return response;
  }

  ///this is if we have staging server to use when we are debugging
  ///and when we want to release it will take the real server URL
  ///
  ///without the need to change it manually
  String getBaseURL() {
    if (Foundation.kDebugMode)
      return BaseURLSTAGING;
    else
      return BaseURL;
  }

  String getApiKey() {
    if (Foundation.kDebugMode)
      return ApiKeyStaging;
    else
      return ApiKey;
  }

  Map<String, String> getHeaders({Map extraHeaders}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-api-key': getApiKey(),
    };
    if (extraHeaders == null || extraHeaders.isEmpty)
      return headers;
    else {
      headers.addAll(extraHeaders);
      return headers;
    }
  }

  Map<String, String> getImageHeaders() {
    return <String, String>{'Content-Type': 'image/png'};
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => developer.log(match.group(0)));
  }
}
