import 'package:flutter/material.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:intl/intl.dart';

class PriceChangeUtils {
  PriceChangeUtils._();

  static Color getColor(double? priceChange) {
    if (priceChange == null || priceChange >= 0) {
      return AppExtraColors.success;
    }
    return AppExtraColors.danger;
  }

  static String formatPrice(double? value) {
    if (value == null) return '\$0';
    if (value >= 1e12) return '\$${(value / 1e12).toStringAsFixed(2)}T';
    if (value >= 1e9) return '\$${(value / 1e9).toStringAsFixed(2)}B';
    return '\$${value.toStringAsFixed(0)}';
  }

  static String formatPriceWithCommas(double? value) {
    if (value == null) return '\$0';
    return NumberFormat.decimalPattern().format(value);
  }
}
