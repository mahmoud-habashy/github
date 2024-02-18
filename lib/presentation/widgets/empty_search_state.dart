import 'package:flutter/material.dart';
import 'package:github/presentation/widgets/primary_button.dart';
import 'package:github/shared/app_assets.dart';
import 'package:github/shared/app_colors.dart';
import 'package:github/shared/app_constants.dart';
import 'package:github/shared/app_strings.dart';
import 'package:lottie/lottie.dart';

/// This is the [HomeScreen]'s first scenario.
/// if the user opens the app for first time or the user does not have any recent searches stored in his device.
///

class EmptySearchState extends StatelessWidget {
  /// [onPrimaryBtnPressed] is required argument, the callback function that gets invoked on every tap.
  /// [isPrimaryBtnActive] is required argument, to switch the button from active mode or disable mode.
  /// to make sure that the [SearchInputField] is not empty also to prevent the user from clicking on the [PrimaryButton] while fetching the data.
  ///
  final VoidCallback onPrimaryBtnPressed;
  final bool isPrimaryBtnActive;
  const EmptySearchState(
      {super.key,
      required this.isPrimaryBtnActive,
      required this.onPrimaryBtnPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: AppConstants.containerElement * 22,
                height: AppConstants.containerElement * 22,
                child: Lottie.asset(AppAssets.searchEmptyStateAnimation,
                    repeat: true)),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.defaultPadding * 2),
              child: PrimaryButton(
                isActive: isPrimaryBtnActive,
                text: AppStrings.emptySearchStateBtnText,
                textColor: AppColors.white,
                fillColor: AppColors.primary,
                onPressed: onPrimaryBtnPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
