import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/features/buy_crypto/domain/repository/buy_crypto_repo.dart';
import 'package:team_7/features/buy_crypto/presentation/cubit/buy_crypto_state.dart';

class BuyCryptoCubit extends Cubit<BuyCryptoState> {
  final BuyCryptoRepo _repository;
  
  static const double defaultFeePercent = 0.05;

  BuyCryptoCubit(this._repository) : super(BuyCryptoInitial());

  /// Fetch initial price and calculate conversion
  Future<void> fetchPrice({
    required String cryptoId,
    required String cryptoSymbol,
    double initialPayAmount = 1800.0,
    String payCurrency = 'USD',
  }) async {
    emit(BuyCryptoLoading());

    try {
      final priceData = await _repository.getCoinPrice(cryptoId);
      
      // Calculate exchange rate (how much crypto per 1 USD)
      final exchangeRate = 1 / priceData.price;
      
      // Calculate receive amount
      final receiveAmount = initialPayAmount * exchangeRate;
      
      // Calculate fee
      final feeAmount = _repository.calculateFee(
        initialPayAmount,
        feePercent: defaultFeePercent,
      );

      emit(BuyCryptoPriceLoaded(
        priceData: priceData,
        payAmount: initialPayAmount,
        receiveAmount: receiveAmount,
        exchangeRate: exchangeRate,
        feePercent: defaultFeePercent,
        feeAmount: feeAmount,
        payCurrency: payCurrency,
        receiveCurrency: cryptoSymbol,
        receiveCryptoId: cryptoId,
      ));
    } catch (e) {
      emit(BuyCryptoError(e.toString()));
    }
  }

  /// Update pay amount and recalculate receive amount
  void updatePayAmount(double newAmount) {
    final currentState = state;
    if (currentState is BuyCryptoPriceLoaded) {
      final receiveAmount = newAmount * currentState.exchangeRate;
      final feeAmount = _repository.calculateFee(
        newAmount,
        feePercent: currentState.feePercent,
      );

      emit(currentState.copyWith(
        payAmount: newAmount,
        receiveAmount: receiveAmount,
        feeAmount: feeAmount,
      ));
    }
  }

  /// Change the cryptocurrency to receive
  Future<void> changeCrypto({
    required String cryptoId,
    required String cryptoSymbol,
  }) async {
    final currentState = state;
    if (currentState is BuyCryptoPriceLoaded) {
      emit(BuyCryptoLoading());

      try {
        final priceData = await _repository.getCoinPrice(cryptoId);
        
        final exchangeRate = 1 / priceData.price;
        final receiveAmount = currentState.payAmount * exchangeRate;

        emit(currentState.copyWith(
          priceData: priceData,
          receiveAmount: receiveAmount,
          exchangeRate: exchangeRate,
          receiveCurrency: cryptoSymbol,
          receiveCryptoId: cryptoId,
        ));
      } catch (e) {
        emit(BuyCryptoError(e.toString()));
      }
    }
  }

  /// Parse and update amount from text input
  void updatePayAmountFromText(String text) {
    // Remove currency symbol and commas
    final cleanText = text.replaceAll(RegExp(r'[^\d.]'), '');
    final amount = double.tryParse(cleanText) ?? 0.0;
    updatePayAmount(amount);
  }
}



