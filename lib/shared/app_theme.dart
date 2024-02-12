import 'package:flutter/material.dart';
import 'package:github/shared/app_colors.dart';

ThemeData githubThemeData = ThemeData(
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primary,
    selectionColor: AppColors.primary,
    selectionHandleColor: AppColors.primary,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: githubTextTheme,
  fontFamily: "Lato",
);

TextTheme githubTextTheme = const TextTheme(
    displayLarge: _displayLarge,
    displayMedium: _displayMedium,
    displaySmall: _displaySmall,
    bodyLarge: _bodyLarge,
    bodyMedium: _bodyMedium,
    bodySmall: _bodySmall,
    labelSmall: _labelSmall);

const TextStyle _displayLarge = TextStyle(
    color: AppColors.textColor,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    fontFamily: 'Lato');

const TextStyle _displayMedium = TextStyle(
    color: AppColors.textColor,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontFamily: 'Lato');

const TextStyle _displaySmall = TextStyle(
    color: AppColors.textColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: 'Lato');

const TextStyle _bodyLarge = TextStyle(
    color: AppColors.textColor,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: 'Lato');
const TextStyle _bodyMedium = TextStyle(
    color: AppColors.textColor,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: 'Lato');
const TextStyle _bodySmall = TextStyle(
    color: AppColors.textColor,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: 'Lato');

const TextStyle _labelSmall = TextStyle(
    color: AppColors.textColor,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    fontFamily: 'Lato');
