import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/app_text.dart';
import 'package:team_7/core/responsive/app_spacing.dart';
import 'package:team_7/features/portfolio/data/models/trending_coin_model.dart';

class TrendingCoinItem extends StatelessWidget {
  final TrendingCoinModel coin;

  const TrendingCoinItem({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.wp(4)),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icon/Thumb
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(coin.thumb),
                fit: BoxFit.cover,
                onError:
                    (_, __) {}, // Handle error silently or show placeholder
              ),
            ),
          ),
          AppSpacing.w12,

          // Name & Symbol
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coin.name,
                  style: AppText.white18Medium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                AppSpacing.h4,
                Text(
                  coin.symbol,
                  style: AppText.gray12Regular.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Price & Change
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                coin.formattedPrice,
                style: AppText.white14Regular.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.onSurface,
                ),
              ),
              AppSpacing.h4,
              Text(
                coin.formattedChange,
                style: AppText.white14Regular.copyWith(
                  fontWeight: FontWeight.w600,
                  color: coin.isPositive
                      ? AppExtraColors.success
                      : AppExtraColors.danger,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
