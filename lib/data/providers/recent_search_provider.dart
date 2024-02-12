import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/data/models/user_model.dart';
import 'package:github/data/repositories/recent_search_repository.dart';

final storedUserDataProvider =
    StateNotifierProvider<_StoredUserDataNotifier, List<UserModel>>(
        (ref) => _StoredUserDataNotifier());

class _StoredUserDataNotifier extends StateNotifier<List<UserModel>> {
  _StoredUserDataNotifier() : super([]);

  Future<void> fetchRecentSearch() async {
    try {
      List<UserModel> recentSearchResults =
          await RecentSearchRepository.fetchRecentSearch();
      state = recentSearchResults;
    } catch (err) {
      debugPrint("Error while fetching recent search data");
      state = [];
    }
  }

  Future<void> addRecentSearch(UserModel userModel) async {
    try {
      bool result = await RecentSearchRepository.addRecentSearch(userModel);
      if (result) {
        List<UserModel> updatedRecentSearch = [...state];
        updatedRecentSearch.removeWhere(
            (storedUserModel) => storedUserModel.id == userModel.id);
        updatedRecentSearch.insert(0, userModel);
        state = updatedRecentSearch;
      }
    } catch (err) {
      debugPrint("Error while adding recent search data");
    }
  }

  Future<void> removeRecentSearch(UserModel userModel) async {
    try {
      bool result = await RecentSearchRepository.removeRecentSearch(userModel);
      if (result) {
        List<UserModel> updatedRecentSearch = [...state];
        updatedRecentSearch.removeWhere(
            (storedUserModel) => storedUserModel.id == userModel.id);
        state = updatedRecentSearch;
      }
    } catch (err) {
      debugPrint("Error while removing recent search data");
    }
  }

  Future<void> resetRecentSearch() async {
    try {
      bool result = await RecentSearchRepository.resetRecentSearch();
      if (result) {
        state = [];
      }
    } catch (err) {
      debugPrint("Error while resetting recent search data");
    }
  }
}
