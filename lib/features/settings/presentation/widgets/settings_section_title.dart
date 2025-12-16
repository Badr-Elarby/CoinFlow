import 'package:flutter/material.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/core/theming/app_text.dart';
import 'package:team_7/core/theming/app_colors.dart';

class SettingsSectionTitle extends StatelessWidget {
  final String title;

  const SettingsSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppText.gray14Medium.copyWith(
        color: context.isDarkMode
            ? AppExtraColors.paleSky
            : AppExtraColors.navyBlue,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
