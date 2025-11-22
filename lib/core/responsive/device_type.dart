import 'package:flutter/widgets.dart';

class DeviceType {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide < 600;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }
}
