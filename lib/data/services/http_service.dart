import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/shared/app_strings.dart';
import 'package:http/http.dart' as http;

enum RequestMethod { get, post, put, delete }

class HttpService {
  Future<String?> sendHttpRequest(
      {required RequestMethod method,
      required String url,
      String? body}) async {
    try {
      http.Response response;
      switch (method) {
        case RequestMethod.get:
          response = await http.get(Uri.parse(url));
        case RequestMethod.post:
          response = await http.post(Uri.parse(url), body: body);
        case RequestMethod.put:
          response = await http.put(Uri.parse(url), body: body);
        case RequestMethod.delete:
          response = await http.delete(Uri.parse(url), body: body);
      }
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw response.body;
      }
    } catch (err) {
      String message = AppStrings.checkInternetErrorMessage;
      try {
        Map<String, dynamic> jsonMessage =
            jsonDecode(err.toString()) as Map<String, dynamic>;
        message = jsonMessage['message'];
      } catch (_) {
        debugPrint("The provided error is not valid JSON Error: $err");
      }
      throw message;
    }
  }
}

final httpServiceProvider = Provider<HttpService>((ref) => HttpService());
