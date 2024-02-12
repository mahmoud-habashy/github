import 'package:flutter/material.dart';
import 'package:github/shared/app_constants.dart';

/// A customized primary rounded button widget.

class PrimaryButton extends StatelessWidget {
  /// [text] is required argument for the button text.
  /// [textColor] is required argument to change the text color.
  /// [fillColor] is required argument to change the background color.
  /// [onPressed] is required argument, the callback function that gets invoked on every tap.
  /// [isActive] is optional argument to switch the button from active mode or disable mode, the default value is true.
  ///
  final String text;
  final Color textColor;
  final Color fillColor;
  final VoidCallback onPressed;
  final bool isActive;
  const PrimaryButton(
      {super.key,
      required this.text,
      required this.textColor,
      required this.onPressed,
      required this.fillColor,
      this.isActive = true});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: isActive ? onPressed : null,
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                vertical: AppConstants.paddingElement * 2,
                horizontal: AppConstants.defaultPadding),
            backgroundColor: isActive ? fillColor : fillColor.withOpacity(0.3),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppConstants.radiusElement * 6))),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: textColor.withOpacity(isActive ? 1.0 : 0.4)),
        ));
  }
}
