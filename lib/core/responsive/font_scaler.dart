import 'package:flutter/widgets.dart';

double scaleFont(BuildContext context, double base) {
  final shortestSide = MediaQuery.of(context).size.shortestSide;

  if (shortestSide >= 600) {
    return base * 1.12;
  }

  return base;
}
