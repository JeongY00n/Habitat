import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class BaseUrl {
  final String rooturl = "k8a704.p.ssafy.io:8081/api";
}

const storage = FlutterSecureStorage();

enum RequestType { get, post, put, patch, delete }

baseApi({
  required String path,
  required RequestType requestType,
  required dynamic Function(dynamic) success,
  required Function(String error) fail,
  Map<String, dynamic>? body,
}) async {
  String url = "http://k8a704.p.ssafy.io:8081/api/$path";
  // Future<String?> accessToken = storage.read(key: "accessToken");
  // Future<String?> refreshToken = storage.read(key: "refreshToken");
  // String? authorization = await accessToken;

  Map<String, String> headers = {
    "Content-Type": "application/json",
    // "Authorization": "$authorization",
    "Authorization":
        "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJXNGFQSE0zSGVtazRnSWkiLCJoYWJpdGF0IjoiVVNFUiIsImV4cCI6MTY4Mzk1ODQ0OX0.K-XosHs_0U-CkqNp8R9aeMlWKJLzbfhoch7dmbP4pRkIJjiUC5n41a9Amwl2ZDejAT3BX6kxwvvpYZM4j3bW-g",
  };

  debugPrint(url);
  Uri uri = Uri.parse(url);
  debugPrint("$uri");

  late http.Response response;

  switch (requestType) {
    case RequestType.get:
      try {
        response = await http.get(uri, headers: headers);
      } catch (e) {
        debugPrint('에러 발생 : $e');
        fail('$e');
        // if (e == 'EXPIRED_JWT_EXCEPTION') {
        //   http.post(url)
        // }
      }
      break;
    case RequestType.post:
      try {
        response =
            await http.post(uri, headers: headers, body: json.encode(body));
      } catch (e) {
        debugPrint('에러 발생 : $e');
        fail('$e');
      }
      break;
    case RequestType.put:
      try {
        response =
            await http.put(uri, headers: headers, body: json.encode(body));
      } catch (e) {
        debugPrint('에러 발생 : $e');
        fail('$e');
      }
      break;
    case RequestType.patch:
      try {
        response =
            await http.patch(uri, headers: headers, body: json.encode(body));
      } catch (e) {
        debugPrint('에러 발생 : $e');
        fail('$e');
      }
      break;
    case RequestType.delete:
      try {
        response =
            await http.delete(uri, headers: headers, body: json.encode(body));
      } catch (e) {
        debugPrint('에러 발생 : $e');
        fail('$e');
      }
      break;
  }

  if (response.body.isNotEmpty) {
    late dynamic jsonResponse;
    jsonResponse = await jsonDecode(utf8.decode(response.bodyBytes));
    return success(jsonResponse);
  }
}
