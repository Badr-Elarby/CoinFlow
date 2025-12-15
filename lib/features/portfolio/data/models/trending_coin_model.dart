class TrendingCoinModel {
  final String id;
  final String coinId;
  final String name;
  final String symbol;
  final String thumb;
  final double? price;
  final double? priceChangePercentage24h;

  TrendingCoinModel({
    required this.id,
    required this.coinId,
    required this.name,
    required this.symbol,
    required this.thumb,
    this.price,
    this.priceChangePercentage24h,
  });

  factory TrendingCoinModel.fromJson(Map<String, dynamic> json) {
    final item = json['item'];
    final data = item['data'] ?? {};

    // Parse price which might be a formatted string like "$0.123" or number
    double? parsedPrice;
    if (data['price'] != null) {
      if (data['price'] is num) {
        parsedPrice = (data['price'] as num).toDouble();
      } else if (data['price'] is String) {
        String p = data['price'];
        p = p.replaceAll('\$', '').replaceAll(',', '');
        parsedPrice = double.tryParse(p);
      }
    }

    // Parse change percentage
    double? parsedChange;
    if (data['price_change_percentage_24h'] != null) {
      final changeMap = data['price_change_percentage_24h'];
      if (changeMap is Map && changeMap['usd'] != null) {
        parsedChange = (changeMap['usd'] as num).toDouble();
      }
    }

    return TrendingCoinModel(
      id: item['id'] as String,
      coinId: item['coin_id'].toString(),
      name: item['name'] as String,
      symbol: item['symbol'] as String,
      thumb: item['thumb'] as String,
      price: parsedPrice,
      priceChangePercentage24h: parsedChange,
    );
  }

  // Helper for UI
  String get formattedPrice =>
      price != null ? '\$${price!.toStringAsFixed(4)}' : 'N/A';

  String get formattedChange {
    if (priceChangePercentage24h == null) return '0.00%';
    final sign = priceChangePercentage24h! >= 0 ? '+' : '';
    return '$sign${priceChangePercentage24h!.toStringAsFixed(2)}%';
  }

  bool get isPositive => (priceChangePercentage24h ?? 0) >= 0;
}
