import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/core/theming/app_text.dart';
import 'package:team_7/core/theming/app_colors.dart';

class SettingsItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const SettingsItemTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.hp(1)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
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
                  style: AppText.paleSky16Regular.copyWith(
                    color: context.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Arrow Icon
              Icon(
                Icons.chevron_right,
                color: context.onSurface.withValues(alpha: 0.5),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
