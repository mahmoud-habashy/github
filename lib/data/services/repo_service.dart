import 'dart:convert';

import 'package:github/config/app_config.dart';
import 'package:github/data/services/http_service.dart';

class RepoService {
  static Future<dynamic> getReposByUserName(
      {required String userName, required int page}) async {
    final url =
        "${AppConfig.getUserReposUrl}/$userName/repos?per_page=${AppConfig.reposCountPerPage}&page=$page&sort=pushed";
    final responseBody =
        await HttpService.sendHttpRequest(method: RequestMethod.get, url: url);
    if (responseBody != null) {
      List<dynamic> json = jsonDecode(responseBody);
      return json;
    }
  }
}
