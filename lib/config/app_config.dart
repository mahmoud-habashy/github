class AppConfig {
  static const String appName = "Github";
  static const String baseUrl = "https://api.github.com";

  static const String getUserByNameUrl = "$baseUrl/users";
  static const String getUserReposUrl = "$baseUrl/users";

  static const int reposCountPerPage = 30;
}

class AppSharedPreferencesKeys {
  static const String recentSearch = "recent_search_users";
}
