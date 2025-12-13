import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/app_spacing.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/features/portfolio/data/models/coin_model.dart';
import 'package:team_7/features/portfolio/presentation/widgets/holding_card.dart';

class HoldingsList extends StatelessWidget {
  final List<CoinModel> coins;

  const HoldingsList({super.key, required this.coins});

  // Map coin IDs to colors
  Color _getCoinColor(String coinId) {
    switch (coinId.toLowerCase()) {
      case 'bitcoin':
        return AppExtraColors.warning;
      case 'ethereum':
        return AppExtraColors.blueAccent;
      case 'litecoin':
        return AppExtraColors.cyanDark;
      default:
        return AppExtraColors.purple;
    }
  }

  // Map coin IDs to icons
  String _getCoinIcon(String coinId) {
    switch (coinId.toLowerCase()) {
      case 'bitcoin':
        return 'B';
      case 'ethereum':
        return 'Ξ';
      case 'litecoin':
        return 'Ł';
      default:
        return coinId[0].toUpperCase();
    }
  }

  // Get static quantity for each coin (will be replaced with real data later)
  double _getQuantity(String coinId) {
    switch (coinId.toLowerCase()) {
      case 'bitcoin':
        return 0.05;
      case 'ethereum':
        return 1.5;
      case 'litecoin':
        return 26.3;
      default:
        return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: coins.map((coin) {
        final quantity = _getQuantity(coin.id);
        final value = quantity * coin.currentPrice;
        final totalValue = coins.fold<double>(
          0,
          (sum, c) => sum + (_getQuantity(c.id) * c.currentPrice),
        );
        final percentage = (value / totalValue) * 100;

        return Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.h12.height!),
          child: HoldingCard(
            name: coin.name,
            symbol: coin.symbol.toUpperCase(),
            quantity: quantity.toStringAsFixed(2),
            value: '\$${value.toStringAsFixed(2)}',
            percentage: '${percentage.toStringAsFixed(0)}%',
            change: coin.formattedPriceChange,
            changePercent: coin.formattedPercentageChange,
            iconColor: _getCoinColor(coin.id),
            icon: _getCoinIcon(coin.id),
          ),
        );
      }).toList(),
    );
  }
}
