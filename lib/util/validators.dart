import 'package:github/shared/app_strings.dart';

String? isValidUserName(String? userName) {
  userName = userName?.trim();
  if (userName == null || userName.isEmpty) {
    return AppStrings.requiredUserNameMessage;
  } else if (userName.length < 3) {
    return AppStrings.invalidUserNameMessage;
  }
  return null;
}
