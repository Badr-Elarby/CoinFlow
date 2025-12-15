import 'package:flutter/material.dart';
import 'package:team_7/features/home/data/model/market_coin_model.dart';
import 'package:team_7/features/home/presentation/widgets/top_gainer_item.dart';

class TopGainers extends StatelessWidget {
  final List<MarketCoinModel> coins;
  final Function(MarketCoinModel)? onCoinTap;

  const TopGainers({super.key, required this.coins, this.onCoinTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Gainers',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: coins.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return TopGainerItem(
                coin: coins[index],
                onTap: () => onCoinTap!(coins[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}
