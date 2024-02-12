String? isValidUserName(String? userName) {
  userName = userName?.trim();
  if (userName == null || userName.isEmpty) {
    return "User name is required";
  } else if (userName.length < 3) {
    return "please enter valid user name.";
  }
  return null;
}
