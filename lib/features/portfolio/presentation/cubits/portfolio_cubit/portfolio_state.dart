import 'package:equatable/equatable.dart';
import 'package:team_7/features/portfolio/data/models/coin_model.dart';
import 'package:team_7/features/portfolio/data/models/portfolio_balance_model.dart';
import 'package:team_7/features/portfolio/data/models/trending_coin_model.dart';

abstract class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object?> get props => [];
}

class PortfolioInitial extends PortfolioState {
  const PortfolioInitial();
}

class PortfolioLoading extends PortfolioState {
  const PortfolioLoading();
}

class PortfolioSuccess extends PortfolioState {
  final PortfolioBalanceModel balance;
  final List<CoinModel> coins;
  final List<TrendingCoinModel> trendingCoins;

  const PortfolioSuccess({
    required this.balance,
    required this.coins,
    required this.trendingCoins,
  });

  @override
  List<Object?> get props => [balance, coins, trendingCoins];
}

class PortfolioError extends PortfolioState {
  final String message;

  const PortfolioError(this.message);

  @override
  List<Object?> get props => [message];
}
