import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/shared/common_layers/data/model/market_coin_model.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/features/market/presentation/widgets/coin_icon.dart';

class MarketCoinTile extends StatelessWidget {
  final MarketCoinModel coin;
  final VoidCallback? onTap;

  const MarketCoinTile({super.key, required this.coin, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isPositive = coin.isPriceChangePositive;
    final changeColor = isPositive
        ? AppExtraColors.success
        : AppExtraColors.danger;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.outline.withAlpha(51), width: 1),
        ),
        child: Row(
          children: [
            CoinIcon(imageUrl: coin.image),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.name ?? 'Unknown',
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: context.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Rank #${coin.marketCapRank ?? '-'}',
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: context.onSurface.withAlpha(128),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  coin.formattedPrice,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                // Price Change Badge
                _priceChangeBadge(
                  change: coin.formattedPriceChange,
                  isPositive: isPositive,
                  color: changeColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _priceChangeBadge({
  required String change,
  required bool isPositive,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(26),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isPositive
              ? Icons.arrow_drop_up_rounded
              : Icons.arrow_drop_down_rounded,
          color: color,
          size: 18,
        ),
        Text(
          change,
          style: GoogleFonts.lato(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    ),
  );
}
