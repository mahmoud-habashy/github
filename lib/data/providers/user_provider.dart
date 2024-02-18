import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/data/models/user_model.dart';
import 'package:github/data/providers/recent_search_provider.dart';
import 'package:github/data/repositories/user_repository.dart';
import 'package:github/shared/app_strings.dart';

final selectedUserProvider =
    StateNotifierProvider<_SelectedUserDataNotifier, UserModel?>(
        (ref) => _SelectedUserDataNotifier());

class _SelectedUserDataNotifier extends StateNotifier<UserModel?> {
  _SelectedUserDataNotifier() : super(null);

  void setSelectedUser(UserModel userModel) {
    state = userModel;
  }
}

final userProvider = StateNotifierProvider<_UserStateNotifier, UserState>(
    (ref) => _UserStateNotifier(ref: ref));

class _UserStateNotifier extends StateNotifier<UserState> {
  Ref ref;
  _UserStateNotifier({required this.ref}) : super(UserState(isLoading: false));

  Future<bool> getUserByName(String userName) async {
    bool result = false;
    try {
      state = UserState(isLoading: true);
      UserModel? data = await ref
          .watch(userRepositoryProvider)
          .getUserByName(userName: userName);
      if (data != null) {
        ref.watch(selectedUserProvider.notifier).setSelectedUser(data);
        await ref.watch(storedUserDataProvider.notifier).addRecentSearch(data);
        state = UserState(userModel: data, isLoading: false);
        result = true;
      } else {
        state = UserState(
            isLoading: false, errorMessage: AppStrings.errorTitleText);
      }
    } catch (err) {
      state = UserState(isLoading: false, errorMessage: err.toString());
    }
    return result;
  }
}

class UserState {
  bool isLoading;
  String? errorMessage;
  UserModel? userModel;
  UserState({this.errorMessage, this.userModel, required this.isLoading});
}
