import 'package:flutter/widgets.dart';
import 'device_type.dart';

class ResponsiveValue<T> {
  final T mobile;
  final T tabletPortrait;
  final T tabletLandscape;

  ResponsiveValue({
    required this.mobile,
    required this.tabletPortrait,
    required this.tabletLandscape,
  });

  T value(BuildContext context) {
    if (DeviceType.isMobile(context)) return mobile;
    if (DeviceType.isTabletLandscape(context)) return tabletLandscape;
    return tabletPortrait; // Tablet → portrait default
  }
}
