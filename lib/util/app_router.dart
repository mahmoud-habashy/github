import 'package:flutter/material.dart';
import 'package:github/presentation/screens/dashboard_screen.dart';
import 'package:github/presentation/screens/home_screen.dart';
import 'package:github/presentation/screens/splash_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case AppRoutes.homeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case AppRoutes.dashboardScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const DashboardScreen());
    }
    return null;
  }
}

class AppRoutes {
  static const String splashScreen = "/";
  static const String homeScreen = "/home";
  static const String dashboardScreen = "/dashboard";
}

void openLink(String link) async {
  final Uri uri = Uri.parse(link);
  if (await canLaunchUrl(uri)) {
    launchUrl(uri);
  }
}
