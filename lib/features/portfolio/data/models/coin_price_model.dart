class CoinPriceModel {
  final Map<String, CoinPriceData> prices;

  CoinPriceModel({required this.prices});

  factory CoinPriceModel.fromJson(Map<String, dynamic> json) {
    Map<String, CoinPriceData> prices = {};
    json.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        prices[key] = CoinPriceData.fromJson(value);
      }
    });
    return CoinPriceModel(prices: prices);
  }
}

class CoinPriceData {
  final double usd;
  final double? usd24hChange;

  CoinPriceData({required this.usd, this.usd24hChange});

  factory CoinPriceData.fromJson(Map<String, dynamic> json) {
    return CoinPriceData(
      usd: (json['usd'] as num).toDouble(),
      usd24hChange: json['usd_24h_change'] != null
          ? (json['usd_24h_change'] as num).toDouble()
          : null,
    );
  }
}
