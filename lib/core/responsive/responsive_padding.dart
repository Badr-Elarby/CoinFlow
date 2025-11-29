import 'package:flutter/widgets.dart';
import 'device_type.dart';

EdgeInsets responsivePadding(BuildContext context) {
  if (DeviceType.isTablet(context)) {
    if (DeviceType.isLandscape(context)) {
      return const EdgeInsets.all(32);
    }
    return const EdgeInsets.all(24);
  }
  return const EdgeInsets.all(16);
}
