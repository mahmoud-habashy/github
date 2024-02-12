import 'package:github/data/models/repo_model.dart';
import 'package:github/data/services/repo_service.dart';

class RepoRepository {
  static Future<List<RepoModel>> getReposByUserName(
      {required String userName, required int page}) async {
    List<RepoModel> result = [];
    dynamic jsonList =
        await RepoService.getReposByUserName(userName: userName, page: page);
    if (jsonList != null) {
      result = RepoModel.listFromJson(jsonList);
    }
    return result;
  }
}
