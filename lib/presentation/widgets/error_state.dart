import 'package:flutter/material.dart';
import 'package:github/presentation/widgets/primary_button.dart';
import 'package:github/shared/app_assets.dart';
import 'package:github/shared/app_colors.dart';
import 'package:github/shared/app_constants.dart';
import 'package:github/shared/app_strings.dart';
import 'package:lottie/lottie.dart';

/// This widget for representing the error cases.

class ErrorState extends StatelessWidget {
  /// [title] is required argument for the widget's title.
  /// [subtitle] is required argument for the widget's subtitle.
  /// [onRefresh] is optional argument if you provide it the [PrimaryButton] will show up to invoke the callback function.
  ///
  final String title;
  final String subtitle;
  final VoidCallback? onRefresh;
  const ErrorState(
      {super.key, required this.title, required this.subtitle, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: AppConstants.containerElement * 12,
                height: AppConstants.containerElement * 12,
                child: Lottie.asset(
                  AppAssets.errorAnimation,
                  fit: BoxFit.cover,
                  repeat: false,
                )),
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding),
              child: Text(
                subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ),
            if (onRefresh != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.defaultPadding * 2),
                child: PrimaryButton(
                  text: AppStrings.errorPrimaryBtnText,
                  textColor: AppColors.white,
                  fillColor: AppColors.primary,
                  onPressed: onRefresh!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
