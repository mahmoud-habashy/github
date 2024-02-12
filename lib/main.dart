import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github',
      theme: githubThemeData,
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
