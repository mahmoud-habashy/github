import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/config/app_config.dart';
import 'package:github/data/services/http_service.dart';

class UserService {
  Ref ref;
  UserService({required this.ref});
  Future<dynamic> getUserByName({required String userName}) async {
    final url = "${AppConfig.getUserByNameUrl}/$userName";

    final responseBody = await ref
        .watch(httpServiceProvider)
        .sendHttpRequest(method: RequestMethod.get, url: url);

    if (responseBody != null) {
      Map<String, dynamic> json = jsonDecode(responseBody);
      return json;
    }
  }
}

final userServiceProvider =
    Provider<UserService>((ref) => UserService(ref: ref));
