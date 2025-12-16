import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/responsive/app_spacing.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/core/theming/app_text.dart';
import 'package:team_7/core/theming/app_colors.dart';

class UserProfileHeader extends StatelessWidget {
  final String userName;

  const UserProfileHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Profile Picture Circle
          Container(
            width: context.wp(20),
            height: context.wp(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppExtraColors.gray.withValues(alpha: 0.2),
              border: Border.all(
                color: context.outline.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Icon(
                Icons.person,
                size: context.wp(12),
                color: context.primary.withValues(alpha: 0.5),
              ),
            ),
          ),
          AppSpacing.h16,

          // User Name
          Text(
            userName,
            style: AppText.white18Medium.copyWith(
              color: context.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
