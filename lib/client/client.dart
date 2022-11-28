import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:webhttpobfuscator_server/exceptions/malformed_request_exception.dart';
import 'package:webhttpobfuscator_server/log/log.dart';

class Client {
  static Future<Response> performRequest(String rawClientRequest) async {

    final json = jsonDecode(rawClientRequest);

    final String method = json["method"].toUpperCase();
    final String url = json["url"];
    final Map<String, dynamic> headers = Map<String, dynamic>.from(json["headers"]);
    final payload = json["payload"]; // TODO

    final options = BaseOptions(
      headers: headers,
      validateStatus: (status) => true // status code should be redirected to client instead
    );

    final client = Dio(options);

    Log.debug("Proceeding $method to $url...");
    switch(method) {
      case "GET":
        return await client.get(url);
    }
    Log.debug("Error: Request Method $method not found");
    throw MalformedRequestException("HTTP Method not found");
  }
}