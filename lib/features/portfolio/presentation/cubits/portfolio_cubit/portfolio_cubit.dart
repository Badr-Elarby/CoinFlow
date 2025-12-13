import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/features/portfolio/data/repositories/portfolio_repository.dart';
import 'package:team_7/features/portfolio/presentation/cubits/portfolio_cubit/portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final PortfolioRepository _repository;

  PortfolioCubit(this._repository) : super(const PortfolioInitial());

  /// Load complete portfolio data
  Future<void> loadPortfolio() async {
    emit(const PortfolioLoading());

    // Fetch all data in parallel
    final balanceResult = await _repository.fetchTotalBalance();
    final coinsResult = await _repository.fetchPortfolioCoins();
    final trendingResult = await _repository.fetchTrendingCoins();

    // Check if all results are successful
    balanceResult.when(
      onSuccess: (balance) {
        coinsResult.when(
          onSuccess: (coins) {
            trendingResult.when(
              onSuccess: (trendingCoins) {
                emit(
                  PortfolioSuccess(
                    balance: balance,
                    coins: coins,
                    trendingCoins: trendingCoins,
                  ),
                );
              },
              onError: (error) {
                emit(
                  PortfolioError(
                    error.status.errorMessage.isNotEmpty
                        ? error.status.errorMessage
                        : 'Failed to load trending coins',
                  ),
                );
              },
            );
          },
          onError: (error) {
            emit(
              PortfolioError(
                error.status.errorMessage.isNotEmpty
                    ? error.status.errorMessage
                    : 'Failed to load coins',
              ),
            );
          },
        );
      },
      onError: (error) {
        emit(
          PortfolioError(
            error.status.errorMessage.isNotEmpty
                ? error.status.errorMessage
                : 'Failed to load balance',
          ),
        );
      },
    );
  }

  /// Refresh portfolio data
  Future<void> refreshPortfolio() async {
    await loadPortfolio();
  }
}
