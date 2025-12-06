import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Light Theme Palette
  static const Color lightBackground = Color(0xFFF5F8FE);
  static const Color lightSurface = Colors.white;
  static const Color _lightPrimary = Color(0xFF1D3A70); // Brand Navy
  static const Color _lightOnPrimary = Colors.white;
  static const Color _lightOnSurface = Color(0xFF18191F); // Neutral Text
  static const Color _lightSecondaryText = Color(0xFF8E949A);
  static const Color _lightOutline = Color(0xFFCBD5E1);

  // Dark Theme Palette
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF121212);
  static const Color _darkPrimary = Colors.white;
  static const Color _darkOnPrimary = Colors.black;
  static const Color _darkOnSurface = Colors.white; // Main Readable Text
  static const Color _darkSecondaryText = Color(0xFF8E949A);
  static const Color _darkOutline = Color(0xFF5D5C5D);

  // Error Color
  static const Color _error = Color(0xFFF26666);

  /// Light ColorScheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: _lightPrimary,
    onPrimary: _lightOnPrimary,
    secondary: _lightPrimary,
    onSecondary: _lightOnPrimary,
    surface: lightSurface,
    onSurface: _lightOnSurface,
    // Mapping old surfaceVariant to surfaceContainerHighest
    surfaceContainerHighest: lightBackground,
    onSurfaceVariant: _lightSecondaryText,
    outline: Color.fromRGBO(203, 213, 225, 1),
    error: _error,
    onError: Colors.white,
  );

  /// Dark ColorScheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: _darkPrimary,
    onPrimary: _darkOnPrimary,
    secondary: _lightPrimary,
    onSecondary: _darkOnPrimary,
    surface: darkSurface,
    onSurface: _darkOnSurface,
    surfaceContainerHighest: darkBackground,
    onSurfaceVariant: _darkSecondaryText,
    outline: _darkOutline,
    error: _error,
    onError: Colors.black,
  );
}

class AppExtraColors {
  const AppExtraColors._();

  static const Color blueAccent = Color(0xFF4766F9);
  static const Color darkNavyIcon = Color(0xFF1E1F4B);

  // Success
  static const Color success = Color(0xFF00CB6A);
  static const Color successMint = Color(0xFF69D895);

  // Warning
  static const Color warning = Color(0xFFF56C2A);

  // Danger
  static const Color danger = Color(0xFFF26666);
  static const Color softRed = Color(0xFFFF928A);

  // Others
  static const Color purple = Color(0xFF8979FF);
  static const Color cyanLight = Color(0xFF3CC3DF);
  static const Color cyanDark = Color(0xFF51CAE2);
  static const Color gray = Color(0xFF8C8C8C);
  static const Color paleSky = Color(0xFF8E949A);
  static const Color white = Colors.white;
  static const Color steelBlueGrey = Color(0xFF494D58);
  static const Color iceBlue = Color(0xFFF5F8FE);
  static const Color transparent = Colors.transparent;

  // Decorative
  static const Color ellipse = Color(0x1A4F5962); // #4F59621A
}
