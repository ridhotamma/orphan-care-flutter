import 'package:flutter/material.dart';

class AppStyleConfig {
  // Fonts
  static const String primaryFontFamily = 'OpenSans';
  static const String secondaryFontFamily = 'Roboto';

  // Colors
  static const Color primaryColor = Color(0xFF071952);
  static const Color secondaryColor = Color(0xFF088395);
  static const Color accentColor = Color(0xFF37B7C3);
  static const Color errorColor = Color(0xFFFF5630);
  static const Color primaryBackgroundColor = Color(0xFFEBF4F6);
  static const Color secondaryBackgroundColor = Color(0xFFFFFFFF);

  // Text Colors
  static const Color primaryTextColor = Color(0xFF172B4D);
  static const Color secondaryTextColor = Color(0xFF6B778C);

  // Border Colors
  static const Color primaryBorderColor = Color(0xFFDFE1E6);
  static const Color secondaryBorderColor = Color(0xFFB3BAC5);

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

  // Button Styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  static ButtonStyle disabledButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: secondaryBorderColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  static ButtonStyle primaryTextButtonStyle = TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    textStyle: const TextStyle(
      fontFamily: primaryFontFamily,
    ),
  );

  static ButtonStyle secondaryTextButtonStyle = TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
      side: const BorderSide(color: accentColor),
    ),
    textStyle: const TextStyle(
      fontFamily: secondaryFontFamily,
      color: accentColor,
    ),
  );

  // Input Field Styles
  static InputDecoration inputDecoration = InputDecoration(
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

  // Text Styles
  static TextStyle primaryTextStyle = const TextStyle(
    fontFamily: primaryFontFamily,
    color: primaryTextColor,
  );

  static TextStyle secondaryTextStyle = const TextStyle(
    fontFamily: secondaryFontFamily,
    color: secondaryTextColor,
  );

  static TextStyle headlineTextStyle = const TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
  );

  static TextStyle bodyTextStyle = const TextStyle(
    fontFamily: secondaryFontFamily,
    fontSize: 16,
    color: primaryTextColor,
  );
}
