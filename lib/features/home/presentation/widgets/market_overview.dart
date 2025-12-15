import 'package:flutter/material.dart';
import 'package:team_7/core/utils/price_change_utils.dart';
import 'package:team_7/features/home/data/model/global_data_model.dart';
import 'package:team_7/features/home/presentation/widgets/market_stat_card.dart';

class MarketOverview extends StatelessWidget {
  final GlobalDataModel data;

  const MarketOverview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Market Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: MarketStatCard(
                  title: 'Market Cap',
                  value: PriceChangeUtils.formatPrice(
                    data.totalMarketCap?['usd'],
                  ),
                  percentChange: PriceChangeUtils.formatPrice(
                    data.totalMarketCap?['usd'],
                  ),
                  isPositive: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MarketStatCard(
                  title: '24h Volume',
                  value: PriceChangeUtils.formatPrice(data.totalVolume?['usd']),
                  percentChange: PriceChangeUtils.formatPrice(
                    data.totalVolume?['usd'],
                  ),
                  isPositive: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: MarketStatCard(
                  title: 'BTC Dominance',
                  value: '${data.btcDominance.toStringAsFixed(2)}%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MarketStatCard(
                  title: 'Active Coins',
                  value: PriceChangeUtils.formatPriceWithCommas(
                    data.activeCryptocurrencies?.toDouble(),
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
