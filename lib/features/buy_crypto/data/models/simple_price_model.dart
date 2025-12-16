/// Model for CoinGecko /simple/price API response
/// API Docs: https://docs.coingecko.com/v3.0.1/reference/simple-price
/// 
/// Response format:
/// {
///   "bitcoin": {
///     "usd": 67000.50,
///     "usd_24h_change": 2.5
///   },
///   "ethereum": {
///     "usd": 3500.25,
///     "usd_24h_change": -1.2
///   }
/// }
class SimplePriceModel {
  final String coinId;
  final double price;
  final double? priceChange24h;

  SimplePriceModel({
    required this.coinId,
    required this.price,
    this.priceChange24h,
  });

  factory SimplePriceModel.fromJson(String coinId, Map<String, dynamic> json) {
    return SimplePriceModel(
      coinId: coinId,
      price: (json['usd'] as num?)?.toDouble() ?? 0.0,
      priceChange24h: (json['usd_24h_change'] as num?)?.toDouble(),
    );
  }

  /// Parse the full API response which contains multiple coins
  static List<SimplePriceModel> fromJsonList(Map<String, dynamic> json) {
    return json.entries.map((entry) {
      return SimplePriceModel.fromJson(
        entry.key,
        entry.value as Map<String, dynamic>,
      );
    }).toList();
  }

  /// Get exchange rate between two coins
  /// Returns how much of targetCoin you get for 1 unit of sourceCoin
  static double calculateExchangeRate(
    SimplePriceModel source,
    SimplePriceModel target,
  ) {
    if (target.price == 0) return 0;
    return source.price / target.price;
  }
}

/// Model representing a supported cryptocurrency
class CryptoCurrency {
  final String id;
  final String symbol;
  final String name;

  const CryptoCurrency({
    required this.id,
    required this.symbol,
    required this.name,
  });

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) {
    return CryptoCurrency(
      id: json['id'] as String,
      symbol: (json['symbol'] as String).toUpperCase(),
      name: json['name'] as String,
    );
  }

  /// Common cryptocurrencies for quick access
  static const List<CryptoCurrency> popularCryptos = [
    CryptoCurrency(id: 'bitcoin', symbol: 'BTC', name: 'Bitcoin'),
    CryptoCurrency(id: 'ethereum', symbol: 'ETH', name: 'Ethereum'),
    CryptoCurrency(id: 'tether', symbol: 'USDT', name: 'Tether'),
    CryptoCurrency(id: 'solana', symbol: 'SOL', name: 'Solana'),
    CryptoCurrency(id: 'ripple', symbol: 'XRP', name: 'XRP'),
    CryptoCurrency(id: 'cardano', symbol: 'ADA', name: 'Cardano'),
    CryptoCurrency(id: 'dogecoin', symbol: 'DOGE', name: 'Dogecoin'),
  ];

  /// Common fiat currencies (represented as stablecoins for conversion)
  static const List<CryptoCurrency> fiatCurrencies = [
    CryptoCurrency(id: 'usd', symbol: 'USD', name: 'US Dollar'),
    CryptoCurrency(id: 'eur', symbol: 'EUR', name: 'Euro'),
    CryptoCurrency(id: 'gbp', symbol: 'GBP', name: 'British Pound'),
  ];
}




