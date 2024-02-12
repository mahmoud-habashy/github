import 'dart:convert';

import 'package:github/config/app_config.dart';
import 'package:github/data/services/http_service.dart';

class UserService {
  static Future<dynamic> getUserByName({required String userName}) async {
    final url = "${AppConfig.getUserByNameUrl}/$userName";

    final responseBody =
        await HttpService.sendHttpRequest(method: RequestMethod.get, url: url);
    if (responseBody != null) {
      Map<String, dynamic> json = jsonDecode(responseBody);
      return json;
    }
  }
}
