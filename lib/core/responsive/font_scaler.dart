import 'package:flutter/widgets.dart';

double scaleFont(BuildContext context, double baseSize) {
  final shortestSide = MediaQuery.of(context).size.shortestSide;

  if (shortestSide >= 900) {
    // Large tablet
    return baseSize * 1.20;
  } else if (shortestSide >= 600) {
    // Normal tablet
    return baseSize * 1.10;
  } else {
    // Mobile
    return baseSize;
  }
}
