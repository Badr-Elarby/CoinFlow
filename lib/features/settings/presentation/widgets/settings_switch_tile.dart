import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/core/theming/app_text.dart';
import 'package:team_7/core/theming/app_colors.dart';

class SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.hp(1)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.wp(4),
          vertical: context.hp(1.8),
        ),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: context.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppExtraColors.navyBlue,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            SizedBox(width: context.wp(4)),

            // Title
            Expanded(
              child: Text(
                title,
                style: AppText.white14Regular.copyWith(
                  color: context.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Switch
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppExtraColors.white,
              activeTrackColor: AppExtraColors.navyBlue,
            ),
          ],
        ),
      ),
    );
  }
}
