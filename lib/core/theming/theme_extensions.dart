import 'package:flutter/material.dart';

extension ThemeContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get primary => Theme.of(this).colorScheme.primary;

  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get surface => Theme.of(this).colorScheme.surface;

  Color get onSurface => Theme.of(this).colorScheme.onSurface;

  Color get error => Theme.of(this).colorScheme.error;

  Color get onError => Theme.of(this).colorScheme.onError;

  Color get outline => Theme.of(this).colorScheme.outline;

  Color get background => Theme.of(this).colorScheme.surfaceContainerHighest;

  Brightness get brightness => Theme.of(this).brightness;

  bool get isDarkMode => brightness == Brightness.dark;
}
