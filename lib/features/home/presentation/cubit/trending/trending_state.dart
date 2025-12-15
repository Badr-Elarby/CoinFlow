import 'package:team_7/core/networking/api_error_model.dart';
import 'package:team_7/features/home/data/model/trending_coin_model.dart';

sealed class TrendingState {}

final class TrendingInitial extends TrendingState {}

final class TrendingLoading extends TrendingState {}

final class TrendingSuccess extends TrendingState {
  final List<TrendingCoinModel> coins;
  TrendingSuccess(this.coins);
}

final class TrendingError extends TrendingState {
  final ApiErrorModel error;
  TrendingError(this.error);
}
