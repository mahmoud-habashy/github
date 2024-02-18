import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/data/models/repo_model.dart';
import 'package:github/data/services/repo_service.dart';

class RepoRepository {
  Ref ref;
  RepoRepository({required this.ref});

  Future<List<RepoModel>> getReposByUserName(
      {required String userName, required int page}) async {
    List<RepoModel> result = [];
    dynamic jsonList = await ref
        .watch(repoServiceProvider)
        .getReposByUserName(userName: userName, page: page);
    if (jsonList != null) {
      result = RepoModel.listFromJson(jsonList);
    }
    return result;
  }
}

final repoRepositoryProvider =
    Provider<RepoRepository>((ref) => RepoRepository(ref: ref));
