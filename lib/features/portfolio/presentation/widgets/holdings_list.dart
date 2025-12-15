import 'package:flutter/material.dart';
import 'package:team_7/core/responsive/app_spacing.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/features/portfolio/data/models/portfolio_balance_model.dart';
import 'package:team_7/features/portfolio/data/models/coin_model.dart';
import 'package:team_7/features/portfolio/presentation/widgets/holding_card.dart';

class HoldingsList extends StatelessWidget {
  final PortfolioBalanceModel balance;
  final List<CoinModel> coins;

  const HoldingsList({super.key, required this.balance, required this.coins});

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

  // Get static quantity for display (from repository holdings)
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
      children: balance.allocations.map((allocation) {
        // Find matching coin for display data
        final coin = coins.firstWhere(
          (c) => c.id == allocation.coinId,
          orElse: () => coins.first, // Fallback
        );

        final quantity = _getQuantity(allocation.coinId);

        return Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.h12.height!),
          child: HoldingCard(
            name: coin.name,
            symbol: allocation.symbol.toUpperCase(),
            quantity: quantity.toStringAsFixed(2),
            value: allocation.formattedValue,
            percentage: allocation.formattedPercentage,
            change: coin.formattedPriceChange,
            changePercent: coin.formattedPercentageChange,
            iconColor: _getCoinColor(allocation.coinId),
            icon: _getCoinIcon(allocation.coinId),
            isPositive: coin.isPriceIncreasing,
          ),
        );
      }).toList(),
    );
  }
}
