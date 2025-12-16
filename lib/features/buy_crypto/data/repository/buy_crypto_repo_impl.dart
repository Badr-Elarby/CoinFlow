import 'package:team_7/features/buy_crypto/data/models/simple_price_model.dart';
import 'package:team_7/features/buy_crypto/domain/repository/buy_crypto_data_source.dart';
import 'package:team_7/features/buy_crypto/domain/repository/buy_crypto_repo.dart';

/// Implementation of BuyCryptoRepo
class BuyCryptoRepoImpl implements BuyCryptoRepo {
  final BuyCryptoDataSource dataSource;

  BuyCryptoRepoImpl(this.dataSource);

  @override
  Future<SimplePriceModel> getCoinPrice(String coinId) {
    return dataSource.getCoinPrice(coinId);
  }

  @override
  Future<List<SimplePriceModel>> getMultipleCoinPrices(List<String> coinIds) {
    return dataSource.getMultipleCoinPrices(coinIds);
  }

  @override
  Future<double> calculateCryptoAmount({
    required double fiatAmount,
    required String cryptoId,
  }) {
    return dataSource.calculateCryptoAmount(
      fiatAmount: fiatAmount,
      cryptoId: cryptoId,
    );
  }

  @override
  double calculateFee(double amount, {double feePercent = 0.05}) {
    return amount * (feePercent / 100);
  }
}



