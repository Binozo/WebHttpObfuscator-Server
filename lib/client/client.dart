import 'dart:convert';

import 'package:dio/dio.dart';

class Client {
  static Future<Response> performRequest(String rawClientRequest) async {

    final json = jsonDecode(rawClientRequest);

    // TODO

    return Response(requestOptions: RequestOptions(path: ""), headers: Headers.fromMap({}), statusCode: 200, data: "");
  }
}