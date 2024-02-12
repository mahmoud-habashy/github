import 'package:github/data/models/user_model.dart';
import 'package:github/data/services/user_service.dart';

class UserRepository {
  static Future<UserModel?> getUserByName({required String userName}) async {
    UserModel? result;
    dynamic userJson = await UserService.getUserByName(userName: userName);
    if (userJson != null) {
      result = UserModel.fromJson(userJson);
    }
    return result;
  }
}
