import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

ThemeData defaultTheme() {
  return ThemeData(
    primaryColor: AppStyleConfig.primaryColor,
    scaffoldBackgroundColor: AppStyleConfig.secondaryBackgroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppStyleConfig.secondaryColor,
      error: AppStyleConfig.errorColor,
    ),
    textTheme: const TextTheme(
      headlineLarge: AppStyleConfig.headlineTextStyle,
      bodyLarge: AppStyleConfig.bodyTextStyle,
      headlineMedium: AppStyleConfig.headlineMediumTextStyle,
      bodyMedium: AppStyleConfig.bodyMediumTextStyle,
      headlineSmall: AppStyleConfig.headlineSmallTextStyle,
      bodySmall: AppStyleConfig.bodySmallTextStyle,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyleConfig.primaryButtonStyle,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppStyleConfig.primaryBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppStyleConfig.primaryBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppStyleConfig.primaryColor),
      ),
      hintStyle: const TextStyle(color: AppStyleConfig.secondaryTextColor),
      contentPadding: const EdgeInsets.all(10),
    ),
  );
}
