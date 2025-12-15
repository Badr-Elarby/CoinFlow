import 'package:flutter/material.dart';
import 'package:team_7/core/shared/common_layers/data/model/market_coin_model.dart';
import 'package:team_7/features/market/presentation/widgets/market_coin_tile.dart';

class MarketCoinList extends StatelessWidget {
  final List<MarketCoinModel> coins;
  final Function(MarketCoinModel) onCoinTap;

  const MarketCoinList({
    super.key,
    required this.coins,
    required this.onCoinTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: coins.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final coin = coins[index];
        return MarketCoinTile(
          coin: coin,
          onTap: () => onCoinTap(coin),
        );
      },
    );
  }
}