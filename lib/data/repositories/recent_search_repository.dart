import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/data/providers/local_storage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:github/data/models/user_model.dart';
import 'package:github/config/app_config.dart';

class RecentSearchRepository {
  Ref ref;
  RecentSearchRepository({required this.ref});
  Future<List<UserModel>> fetchRecentSearch() async {
    final SharedPreferences pref =
        await ref.read(sharedPreferencesProvider.future);

    final List<String> result =
        pref.getStringList(AppSharedPreferencesKeys.recentSearch) ?? [];
    List<UserModel> userModels = result
        .map((userModel) => UserModel.fromJson(jsonDecode(userModel)))
        .toList();
    return userModels;
  }

  Future<bool> addRecentSearch(UserModel userModel) async {
    final SharedPreferences pref =
        await ref.read(sharedPreferencesProvider.future);
    final List<String> storedData =
        pref.getStringList(AppSharedPreferencesKeys.recentSearch) ?? [];

    final List<UserModel> userModels = storedData
        .map((userModel) => UserModel.fromJson(jsonDecode(userModel)))
        .toList();

    userModels.removeWhere((data) => data.id == userModel.id);
    userModels.insert(0, userModel);

    final List<String> userModelsAsString =
        userModels.map((data) => jsonEncode(data)).toList();

    return await pref.setStringList(
        AppSharedPreferencesKeys.recentSearch, userModelsAsString);
  }

  Future<bool> removeRecentSearch(UserModel userModel) async {
    final SharedPreferences pref =
        await ref.read(sharedPreferencesProvider.future);
    final List<String> storedData =
        pref.getStringList(AppSharedPreferencesKeys.recentSearch) ?? [];

    final List<UserModel> userModels = storedData
        .map((userModel) => UserModel.fromJson(jsonDecode(userModel)))
        .toList();

    userModels.removeWhere((data) => data.id == userModel.id);
    final List<String> userModelsAsString =
        userModels.map((data) => jsonEncode(data)).toList();

    return await pref.setStringList(
        AppSharedPreferencesKeys.recentSearch, userModelsAsString);
  }

  Future<bool> resetRecentSearch() async {
    final SharedPreferences pref =
        await ref.read(sharedPreferencesProvider.future);
    return await pref.remove(AppSharedPreferencesKeys.recentSearch);
  }
}

final recentSearchRepositoryProvider =
    Provider<RecentSearchRepository>((ref) => RecentSearchRepository(ref: ref));
