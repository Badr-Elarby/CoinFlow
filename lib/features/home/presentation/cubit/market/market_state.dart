import 'package:team_7/core/networking/api_error_model.dart';
import 'package:team_7/features/home/data/model/market_coin_model.dart';

sealed class MarketState {}

final class MarketInitial extends MarketState {}

final class MarketLoading extends MarketState {}

final class MarketSuccess extends MarketState {
  final List<MarketCoinModel> coins;
  MarketSuccess(this.coins);
}

final class MarketError extends MarketState {
  final ApiErrorModel error;
  MarketError(this.error);
}
