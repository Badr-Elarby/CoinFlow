import 'package:flutter/material.dart';
import 'package:team_7/core/utils/price_change_utils.dart';
import 'package:team_7/features/home/data/model/market_coin_model.dart';

class TopGainerItem extends StatelessWidget {
  final MarketCoinModel coin;
  final VoidCallback? onTap;

  const TopGainerItem({super.key, required this.coin, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.outline.withAlpha(30),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: PriceChangeUtils.getColor(coin.priceChangePercentage24h),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: coin.image != null
                    ? Image.network(coin.image!, width: 24, height: 24)
                    : Text(
                        (coin.symbol?.isNotEmpty ?? false)
                            ? coin.symbol![0].toUpperCase()
                            : '?',
                        style: TextStyle(
                          color: PriceChangeUtils.getColor(
                            coin.priceChangePercentage24h,
                          ),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.name ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    coin.symbol ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface.withAlpha(120),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  coin.currentPrice?.toString() ?? '0.00',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${(coin.priceChangePercentage24h ?? 0).toStringAsFixed(2)}%',
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
      ),
    );
  }
}
