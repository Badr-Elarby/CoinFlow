import 'package:equatable/equatable.dart';
import 'package:team_7/features/buy_crypto/data/models/simple_price_model.dart';

abstract class BuyCryptoState extends Equatable {
  const BuyCryptoState();

  @override
  List<Object?> get props => [];
}

class BuyCryptoInitial extends BuyCryptoState {}

class BuyCryptoLoading extends BuyCryptoState {}

class BuyCryptoPriceLoaded extends BuyCryptoState {
  final SimplePriceModel priceData;
  final double payAmount;
  final double receiveAmount;
  final double exchangeRate;
  final double feePercent;
  final double feeAmount;
  final String payCurrency;
  final String receiveCurrency;
  final String receiveCryptoId;

  const BuyCryptoPriceLoaded({
    required this.priceData,
    required this.payAmount,
    required this.receiveAmount,
    required this.exchangeRate,
    required this.feePercent,
    required this.feeAmount,
    required this.payCurrency,
    required this.receiveCurrency,
    required this.receiveCryptoId,
  });

  @override
  List<Object?> get props => [
        priceData,
        payAmount,
        receiveAmount,
        exchangeRate,
        feePercent,
        feeAmount,
        payCurrency,
        receiveCurrency,
        receiveCryptoId,
      ];

  BuyCryptoPriceLoaded copyWith({
    SimplePriceModel? priceData,
    double? payAmount,
    double? receiveAmount,
    double? exchangeRate,
    double? feePercent,
    double? feeAmount,
    String? payCurrency,
    String? receiveCurrency,
    String? receiveCryptoId,
  }) {
    return BuyCryptoPriceLoaded(
      priceData: priceData ?? this.priceData,
      payAmount: payAmount ?? this.payAmount,
      receiveAmount: receiveAmount ?? this.receiveAmount,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      feePercent: feePercent ?? this.feePercent,
      feeAmount: feeAmount ?? this.feeAmount,
      payCurrency: payCurrency ?? this.payCurrency,
      receiveCurrency: receiveCurrency ?? this.receiveCurrency,
      receiveCryptoId: receiveCryptoId ?? this.receiveCryptoId,
    );
  }
}

class BuyCryptoError extends BuyCryptoState {
  final String message;

  const BuyCryptoError(this.message);

  @override
  List<Object?> get props => [message];
}



