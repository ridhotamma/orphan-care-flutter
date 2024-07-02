import 'package:flutter/material.dart';
import 'package:frontend_flutter/config/app_style_config.dart';

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppStyleConfig.primaryDarkColor,
    scaffoldBackgroundColor: AppStyleConfig.primaryBackgroundDarkColor,
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: AppStyleConfig.secondaryDarkColor,
      error: AppStyleConfig.errorDarkColor,
    ),
    textTheme: const TextTheme(
      headlineLarge: AppStyleConfig.headlineDarkTextStyle,
      bodyLarge: AppStyleConfig.bodyDarkTextStyle,
      headlineMedium: AppStyleConfig.headlineMediumDarkTextStyle,
      bodyMedium: AppStyleConfig.bodyMediumDarkTextStyle,
      headlineSmall: AppStyleConfig.headlineSmallDarkTextStyle,
      bodySmall: AppStyleConfig.bodySmallDarkTextStyle,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyleConfig.primaryDarkButtonStyle,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppStyleConfig.primaryBackgroundDarkColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide:
            const BorderSide(color: AppStyleConfig.primaryBorderDarkColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide:
            const BorderSide(color: AppStyleConfig.primaryBorderDarkColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppStyleConfig.primaryDarkColor),
      ),
      hintStyle: const TextStyle(color: AppStyleConfig.secondaryTextDarkColor),
      contentPadding: const EdgeInsets.all(10),
    ),
  );
}
