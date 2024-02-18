import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/config/app_config.dart';
import 'package:github/data/services/http_service.dart';

class RepoService {
  Ref ref;
  RepoService({required this.ref});
  Future<dynamic> getReposByUserName(
      {required String userName, required int page}) async {
    final url =
        "${AppConfig.getUserReposUrl}/$userName/repos?per_page=${AppConfig.reposCountPerPage}&page=$page&sort=pushed";

    final responseBody = await ref
        .watch(httpServiceProvider)
        .sendHttpRequest(method: RequestMethod.get, url: url);

    if (responseBody != null) {
      List<dynamic> json = jsonDecode(responseBody);
      return json;
    }
  }
}

final repoServiceProvider =
    Provider<RepoService>((ref) => RepoService(ref: ref));
