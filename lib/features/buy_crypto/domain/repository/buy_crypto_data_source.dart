import 'package:team_7/features/buy_crypto/data/models/simple_price_model.dart';

/// Data source interface for Buy Crypto feature
/// Uses CoinGecko API: https://docs.coingecko.com/v3.0.1/reference/simple-price
abstract class BuyCryptoDataSource {
  /// Get price of a single coin in USD
  /// Uses: GET /simple/price?ids={coinId}&vs_currencies=usd
  Future<SimplePriceModel> getCoinPrice(String coinId);

  /// Get prices of multiple coins in USD
  /// Uses: GET /simple/price?ids={coinIds}&vs_currencies=usd&include_24hr_change=true
  Future<List<SimplePriceModel>> getMultipleCoinPrices(List<String> coinIds);

  /// Calculate exchange rate between fiat (USD) and crypto
  /// Returns how much crypto you get for the given fiat amount
  Future<double> calculateCryptoAmount({
    required double fiatAmount,
    required String cryptoId,
  });
}




