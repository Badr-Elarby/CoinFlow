import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/theming/app_colors.dart';

class AppText {
  AppText._();

  // ---------- Whites ----------
  static final TextStyle white28Bold = GoogleFonts.lato(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppExtraColors.white,
  );

  static final TextStyle white26SemiBold = GoogleFonts.lato(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: AppExtraColors.white,
  );

  static final TextStyle white18Medium = GoogleFonts.lato(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppExtraColors.white,
  );

  static final TextStyle white14Regular = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppExtraColors.white,
  );

  static final TextStyle white12Medium = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppExtraColors.white,
  );

  // ---------- PaleSky (secondary text الفاتح) ----------
  static final TextStyle paleSky18Medium = GoogleFonts.lato(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppExtraColors.paleSky,
  );

  static final TextStyle paleSky16Regular = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppExtraColors.paleSky,
  );

  static final TextStyle paleSky14Medium = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppExtraColors.paleSky,
  );

  static final TextStyle paleSky12Regular = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppExtraColors.paleSky,
  );

  // ---------- Grey / Neutral ----------
  static final TextStyle gray14Medium = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppExtraColors.gray,
  );

  static final TextStyle gray14Bold = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppExtraColors.gray,
  );

  static final TextStyle gray12Regular = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppExtraColors.gray,
  );

  static final TextStyle gray12Medium = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppExtraColors.gray,
  );

  static final TextStyle steelBlueGrey12Regular = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppExtraColors.steelBlueGrey,
  );

  // ---------- Decorative / IceBlue ----------
  static final TextStyle iceBlue14SemiBold = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppExtraColors.iceBlue,
  );

  static final TextStyle iceBlue12Medium = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppExtraColors.iceBlue,
  );

  static final TextStyle blueAccent12Regular = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppExtraColors.blueAccent,
  );

  // ---------- Success / Warning ----------
  static final TextStyle success14Medium = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppExtraColors.success,
  );

  static final TextStyle success12Regular = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppExtraColors.success,
  );

  static final TextStyle warning12Regular = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppExtraColors.warning,
  );
}
