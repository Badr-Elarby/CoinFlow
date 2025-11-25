import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextTheme textTheme(ColorScheme colors) {
    return TextTheme(
      // Heading 1
      headlineLarge: GoogleFonts.lato(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: colors.onSurface,
      ),
      // Heading 2
      headlineMedium: GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: colors.onSurface,
      ),
      // Heading 3
      headlineSmall: GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: colors.onSurface,
      ),
      // Heading 4
      titleLarge: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: colors.onSurface,
      ),
      // Heading 5
      titleMedium: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: colors.onSurface,
      ),
      // Heading 6
      titleSmall: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: colors.onSurface,
      ),

      // Paragraph (Regular)
      bodyLarge: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: colors.onSurface,
      ),
      // Paragraph: Medium
      bodyMedium: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colors.onSurface,
      ),
      // Paragraph: Small
      bodySmall: GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: colors.onSurfaceVariant, // Secondary text often uses variant
      ),

      // Text Button: Large
      labelLarge: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: colors.onPrimary,
      ),
      // Text Button: Small
      labelMedium: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: colors.onPrimary,
      ),
      // Helper text
      labelSmall: GoogleFonts.lato(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: colors.onSurfaceVariant,
      ),
    );
  }
}
