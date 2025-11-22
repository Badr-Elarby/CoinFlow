import 'package:flutter/widgets.dart';

extension SizeExtension on BuildContext {
  // full screen width
  double sw() => MediaQuery.of(this).size.width;

  // full screen height
  double sh() => MediaQuery.of(this).size.height;

  // width percent: pass 0..100
  double wp(double percent) => sw() * (percent / 100);

  // height percent: pass 0..100
  double hp(double percent) => sh() * (percent / 100);
}
