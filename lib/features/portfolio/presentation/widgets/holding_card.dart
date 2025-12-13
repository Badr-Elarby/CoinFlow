import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/app_text.dart';
import 'package:team_7/core/responsive/app_spacing.dart';

class HoldingCard extends StatelessWidget {
  final String name;
  final String symbol;
  final String quantity;
  final String value;
  final String percentage;
  final String change;
  final String changePercent;
  final Color iconColor;
  final String icon;
  final bool isPositive;

  const HoldingCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.quantity,
    required this.value,
    required this.percentage,
    required this.change,
    required this.changePercent,
    required this.iconColor,
    required this.icon,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.wp(4)),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.outline.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                icon,
                style: AppText.white18Medium.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
            ),
          ),
          AppSpacing.w12,

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppText.white18Medium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.onSurface,
                          ),
                        ),
                        Text(
                          symbol,
                          style: AppText.gray12Regular.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      percentage,
                      style: AppText.white14Regular.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.onSurface,
                      ),
                    ),
                  ],
                ),
                AppSpacing.h8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$quantity $symbol',
                          style: AppText.gray12Regular.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          value,
                          style: AppText.white14Regular.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppExtraColors.warning,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          change,
                          style: isPositive
                              ? AppText.success14Medium
                              : AppText.white14Regular.copyWith(
                                  color: AppExtraColors.danger,
                                ),
                        ),
                        Text(
                          changePercent,
                          style: isPositive
                              ? AppText.success12Regular
                              : AppText.gray12Regular.copyWith(
                                  color: AppExtraColors.danger,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
