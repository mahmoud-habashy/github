import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/data/models/repo_model.dart';
import 'package:github/data/repositories/repo_repository.dart';

final reposProvider =
    StateNotifierProvider.autoDispose<_RepoStateNotifier, RepoState>(
        (ref) => _RepoStateNotifier());

class _RepoStateNotifier extends StateNotifier<RepoState> {
  _RepoStateNotifier() : super(RepoState(isLoading: false, repos: []));

  Future<void> getReposByUserName(String userName, int page) async {
    try {
      state = RepoState(isLoading: true, repos: state.repos);
      List<RepoModel> result = await RepoRepository.getReposByUserName(
          userName: userName, page: page);

      state = RepoState(isLoading: false, repos: [...state.repos, ...result]);
    } catch (err) {
      if (!mounted) return;
      state = RepoState(
          isLoading: false, repos: state.repos, errorMessage: err.toString());
    }
  }
}

class RepoState {
  String? errorMessage;
  bool isLoading;
  List<RepoModel> repos;
  RepoState({this.errorMessage, required this.isLoading, required this.repos});
}
