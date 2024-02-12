import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github/config/app_config.dart';
import 'package:github/shared/app_theme.dart';
import 'package:github/util/app_router.dart';

void main() {
  runApp(ProviderScope(
      child: MyApp(
    appRouter: AppRouter(),
  )));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      theme: githubThemeData,
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
