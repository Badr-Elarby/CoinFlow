import 'package:flutter/material.dart';
import 'package:team_7/core/utils/price_change_utils.dart';
import 'package:team_7/features/home/data/model/trending_coin_model.dart';

class TrendingCoinCard extends StatelessWidget {
  final TrendingCoinModel coin;
  const TrendingCoinCard({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outline.withAlpha(30), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
                    coin.name!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    coin.symbol!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface.withAlpha(120),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: PriceChangeUtils.getColor(
                      coin.priceChangePercentage24h,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.network(coin.thumb!, width: 24, height: 24),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            PriceChangeUtils.formatPrice(coin.price),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                coin.priceChangePercentage24h! >= 0
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                color: PriceChangeUtils.getColor(coin.priceChangePercentage24h),
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                '${PriceChangeUtils.formatPrice(coin.priceChangePercentage24h)}%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: PriceChangeUtils.getColor(
                    coin.priceChangePercentage24h,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
