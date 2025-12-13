import 'package:intl/intl.dart';

class PortfolioBalanceModel {
  final double totalValue;
  final double dailyChange;
  final double dailyChangePercentage;
  final List<HoldingAllocation> allocations;

  PortfolioBalanceModel({
    required this.totalValue,
    required this.dailyChange,
    required this.dailyChangePercentage,
    required this.allocations,
  });

  bool get isDailyPositive => dailyChange >= 0;

  String get formattedTotalValue {
    final formatter = NumberFormat('#,##0.00');
    return '\$${formatter.format(totalValue)}';
  }

  String get formattedDailyChange {
    final sign = dailyChange >= 0 ? '+' : '';
    return '$sign\$${dailyChange.toStringAsFixed(2)}';
  }

  String get formattedDailyChangePercentage {
    final sign = dailyChangePercentage >= 0 ? '+' : '';
    return '$sign${dailyChangePercentage.toStringAsFixed(2)}%';
  }
}

class HoldingAllocation {
  final String coinId;
  final String symbol;
  final double value;
  final double percentage;

  HoldingAllocation({
    required this.coinId,
    required this.symbol,
    required this.value,
    required this.percentage,
  });

  String get formattedValue => '\$${value.toStringAsFixed(2)}';
  String get formattedPercentage => '${percentage.toStringAsFixed(0)}%';
}
