import 'package:flutter/material.dart';
import 'package:github/shared/app_assets.dart';
import 'package:github/shared/app_colors.dart';
import 'package:github/shared/app_constants.dart';
import 'package:github/util/app_router.dart';
import 'package:lottie/lottie.dart';

/// A simple splash screen
/// when the user opens the app this is the initial page after two seconds the user will redirected to the [HomeScreen].

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateHomeScreen();
  }

  void _navigateHomeScreen() {
    if (context.mounted) {
      Future.delayed(
          const Duration(seconds: AppConstants.splashScreenDuration),
          () =>
              Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: SizedBox(
            width: AppConstants.containerElement * 25,
            height: AppConstants.containerElement * 25,
            child: Lottie.asset(
              AppAssets.searchEmptyStateAnimation,
              repeat: false,
            )),
      ),
    );
  }
}
