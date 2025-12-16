import 'package:team_7/core/networking/api_constant.dart';
import 'package:team_7/core/networking/api_consumer.dart';
import 'package:team_7/features/buy_crypto/data/models/simple_price_model.dart';
import 'package:team_7/features/buy_crypto/domain/repository/buy_crypto_data_source.dart';

/// Implementation of BuyCryptoDataSource using CoinGecko API
/// API Docs: https://docs.coingecko.com/v3.0.1/reference/simple-price
class BuyCryptoDataSourceImpl implements BuyCryptoDataSource {
  final ApiConsumer apiConsumer;

  BuyCryptoDataSourceImpl({required this.apiConsumer});

  @override
  Future<SimplePriceModel> getCoinPrice(String coinId) async {
    final response = await apiConsumer.get(
      path: ApiConstants.simplePrice,
      queryParameters: {
        'ids': coinId,
        'vs_currencies': 'usd',
        'include_24hr_change': true,
      },
    );

    final prices = SimplePriceModel.fromJsonList(response as Map<String, dynamic>);
    if (prices.isEmpty) {
      throw Exception('No price data found for $coinId');
    }
    return prices.first;
  }

  @override
  Future<List<SimplePriceModel>> getMultipleCoinPrices(List<String> coinIds) async {
    final response = await apiConsumer.get(
      path: ApiConstants.simplePrice,
      queryParameters: {
        'ids': coinIds.join(','),
        'vs_currencies': 'usd',
        'include_24hr_change': true,
      },
    );

    return SimplePriceModel.fromJsonList(response as Map<String, dynamic>);
  }

  @override
  Future<double> calculateCryptoAmount({
    required double fiatAmount,
    required String cryptoId,
  }) async {
    final priceData = await getCoinPrice(cryptoId);
    
    if (priceData.price == 0) {
      return 0;
    }
    
    // Calculate how much crypto you get for the fiat amount
    // e.g., if BTC = $67,000 and you pay $1,000, you get 1000/67000 = 0.0149 BTC
    return fiatAmount / priceData.price;
  }
}




