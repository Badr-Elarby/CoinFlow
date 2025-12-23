import 'package:flutter/widgets.dart';

extension SizeExtension on BuildContext {
  double sw() => MediaQuery.of(this).size.width;
  double sh() => MediaQuery.of(this).size.height;
  double wp(double percent) => sw() * (percent / 100);
  double hp(double percent) => sh() * (percent / 100);
}
