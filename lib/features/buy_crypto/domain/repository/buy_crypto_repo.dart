import 'package:team_7/features/buy_crypto/data/models/simple_price_model.dart';

/// Repository interface for Buy Crypto feature
abstract class BuyCryptoRepo {
  /// Get the current price of a cryptocurrency
  Future<SimplePriceModel> getCoinPrice(String coinId);

  /// Get prices for multiple cryptocurrencies
  Future<List<SimplePriceModel>> getMultipleCoinPrices(List<String> coinIds);

  /// Calculate how much crypto you receive for a given fiat amount
  Future<double> calculateCryptoAmount({
    required double fiatAmount,
    required String cryptoId,
  });

  /// Calculate the exchange fee
  double calculateFee(double amount, {double feePercent = 0.05});
}



