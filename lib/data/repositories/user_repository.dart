import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/data/models/user_model.dart';
import 'package:github/data/services/user_service.dart';

class UserRepository {
  Ref ref;
  UserRepository({required this.ref});
  Future<UserModel?> getUserByName({required String userName}) async {
    UserModel? result;
    dynamic userJson =
        await ref.watch(userServiceProvider).getUserByName(userName: userName);

    if (userJson != null) {
      result = UserModel.fromJson(userJson);
    }
    return result;
  }
}

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepository(ref: ref));
