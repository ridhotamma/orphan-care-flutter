import 'package:flutter/material.dart';

class AppStyleConfig {
  // Fonts
  static const String primaryFontFamily = 'OpenSans';
  static const String secondaryFontFamily = 'Roboto';

  // Light Mode Colors
  static const Color primaryColor = Color(0xFF071952);
  static const Color secondaryColor = Color(0xFF088395);
  static const Color accentColor = Color(0xFF37B7C3);
  static const Color errorColor = Color(0xFFFF5630);
  static const Color primaryBackgroundColor = Color(0xFFEBF4F6);
  static const Color secondaryBackgroundColor = Color(0xFFFFFFFF);

  // Dark Mode Colors
  static const Color primaryDarkColor = Color(0xFF1A1A2E);
  static const Color secondaryDarkColor = Color(0xFF16213E);
  static const Color accentDarkColor = Color(0xFF0F3460);
  static const Color errorDarkColor = Color(0xFFE94560);
  static const Color primaryBackgroundDarkColor = Color(0xFF1C1C1C);
  static const Color secondaryBackgroundDarkColor = Color(0xFF121212);

  // Light Mode Text Colors
  static const Color primaryTextColor = Color(0xFF172B4D);
  static const Color secondaryTextColor = Color(0xFF6B778C);

  // Dark Mode Text Colors
  static const Color primaryTextDarkColor = Color(0xFFEAEAEA);
  static const Color secondaryTextDarkColor = Color(0xFFA1A1A1);

  // Light Mode Border Colors
  static const Color primaryBorderColor = Color(0xFFDFE1E6);
  static const Color secondaryBorderColor = Color(0xFFB3BAC5);

  // Dark Mode Border Colors
  static const Color primaryBorderDarkColor = Color(0xFF3A3A3A);
  static const Color secondaryBorderDarkColor = Color(0xFF555555);

  // Shadows
  static const BoxShadow primaryShadow = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.1),
    blurRadius: 10,
    offset: Offset(0, 4),
  );

  static const BoxShadow secondaryShadow = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05),
    blurRadius: 5,
    offset: Offset(0, 2),
  );

  // Text Styles
  static const TextStyle primaryTextStyle = TextStyle(
    fontFamily: primaryFontFamily,
    color: primaryTextColor,
  );

  static const TextStyle primaryTextDarkStyle = TextStyle(
    fontFamily: primaryFontFamily,
    color: primaryTextDarkColor,
  );

  static const TextStyle secondaryTextStyle = TextStyle(
    fontFamily: secondaryFontFamily,
    color: secondaryTextColor,
  );

  static const TextStyle secondaryTextDarkStyle = TextStyle(
    fontFamily: secondaryFontFamily,
    color: secondaryTextDarkColor,
  );

  static const TextStyle headlineTextStyle = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
  );

  static const TextStyle headlineDarkTextStyle = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryTextDarkColor,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 16,
    color: primaryTextColor,
  );

  static const TextStyle bodyDarkTextStyle = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 16,
    color: primaryTextDarkColor,
  );

  static const TextStyle headlineMediumTextStyle = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
  );

  static const TextStyle headlineMediumDarkTextStyle = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: primaryTextDarkColor,
  );

  static const TextStyle bodyMediumTextStyle = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 14,
    color: primaryTextColor,
  );

  static const TextStyle bodyMediumDarkTextStyle = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 14,
    color: primaryTextDarkColor,
  );

  static const TextStyle headlineSmallTextStyle = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
  );

  static const TextStyle headlineSmallDarkTextStyle = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: primaryTextDarkColor,
  );

  static const TextStyle bodySmallTextStyle = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 12,
    color: primaryTextColor,
  );

  static const TextStyle bodySmallDarkTextStyle = TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 12,
    color: primaryTextDarkColor,
  );

  // Button Styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  static final ButtonStyle primaryDarkButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryDarkColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  static final ButtonStyle errorButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: errorColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  static final ButtonStyle errorDarkButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: errorDarkColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  static final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  static final ButtonStyle secondaryDarkButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryDarkColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  static final ButtonStyle disabledButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryBorderColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  static final ButtonStyle defaultButtonStyle = TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    textStyle: const TextStyle(
      fontFamily: primaryFontFamily,
    ),
  );

  static final InputDecoration inputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: primaryBorderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: primaryBorderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: primaryColor),
    ),
    hintStyle: const TextStyle(color: secondaryTextColor),
    contentPadding: const EdgeInsets.all(10),
  );

  static final InputDecoration inputDarkDecoration = InputDecoration(
    filled: true,
    fillColor: primaryBackgroundDarkColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: primaryBorderDarkColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: primaryBorderDarkColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: primaryDarkColor),
    ),
    hintStyle: const TextStyle(color: secondaryTextDarkColor),
    contentPadding: const EdgeInsets.all(10),
  );
}
