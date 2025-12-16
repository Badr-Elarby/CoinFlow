import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/app_spacing.dart';
import 'package:team_7/features/portfolio/data/models/trending_coin_model.dart';
import 'package:team_7/features/portfolio/presentation/widgets/trending_coin_item.dart';

class TrendingCoinsList extends StatelessWidget {
  final List<TrendingCoinModel> coins;

  const TrendingCoinsList({super.key, required this.coins});

  @override
  Widget build(BuildContext context) {
    if (coins.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: coins
          .map(
            (coin) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.h12.height!),
              child: TrendingCoinItem(coin: coin),
            ),
          )
          .toList(),
    );
  }
}
