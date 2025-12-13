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
    return '\$${_formatNumber(totalValue)}';
  }

  String get formattedDailyChange {
    final sign = dailyChange >= 0 ? '+' : '';
    return '$sign\$${dailyChange.toStringAsFixed(2)}';
  }

  String get formattedDailyChangePercentage {
    final sign = dailyChangePercentage >= 0 ? '+' : '';
    return '$sign${dailyChangePercentage.toStringAsFixed(2)}%';
  }

  String _formatNumber(double value) {
    final parts = value.toStringAsFixed(2).split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];

    String formatted = '';
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        formatted += ',';
      }
      formatted += integerPart[i];
    }

    return '$formatted.$decimalPart';
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
