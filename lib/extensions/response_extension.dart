import 'package:dio/dio.dart';

extension ResponseExtension on Response {
  Map<String, dynamic> convertToJson() => {
    "code" : statusCode,
    "body" : data,
    "headers" : headers.map
  };
}