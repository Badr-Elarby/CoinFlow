part of 'market_cubit.dart';

sealed class MarketState {}

class MarketInitial extends MarketState {}

class MarketLoading extends MarketState {
  final List<MarketCoinModel> coins;

  MarketLoading({required this.coins});
}

class MarketLoaded extends MarketState {
  final List<MarketCoinModel> coins;

  MarketLoaded({required this.coins});
}

class MarketError extends MarketState {
  final ApiErrorModel error;

  MarketError(this.error);
}
