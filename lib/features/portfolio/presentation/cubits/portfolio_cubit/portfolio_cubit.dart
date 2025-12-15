import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/networking/api_result.dart';
import 'package:team_7/features/portfolio/data/repositories/portfolio_repository.dart';
import 'package:team_7/features/portfolio/presentation/cubits/portfolio_cubit/portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final PortfolioRepository _repository;

  PortfolioCubit(this._repository) : super(const PortfolioInitial());

  /// Load complete portfolio data in parallel
  Future<void> loadPortfolio() async {
    emit(const PortfolioLoading());

    // Fetch all data in parallel using Future.wait
    final results = await Future.wait([
      _repository.fetchTotalBalance(),
      _repository.fetchPortfolioCoins(),
      _repository.fetchTrendingCoins(),
    ]);

    final balanceResult = results[0];
    final coinsResult = results[1];
    final trendingResult = results[2];

    // Check for any errors (collect first error if exists)
    if (balanceResult is! ApiSuccess) {
      final error = (balanceResult as ApiError).error;
      emit(
        PortfolioError(
          error.status.errorMessage.isNotEmpty
              ? error.status.errorMessage
              : 'Failed to load balance',
        ),
      );
      return;
    }

    if (coinsResult is! ApiSuccess) {
      final error = (coinsResult as ApiError).error;
      emit(
        PortfolioError(
          error.status.errorMessage.isNotEmpty
              ? error.status.errorMessage
              : 'Failed to load coins',
        ),
      );
      return;
    }

    if (trendingResult is! ApiSuccess) {
      final error = (trendingResult as ApiError).error;
      emit(
        PortfolioError(
          error.status.errorMessage.isNotEmpty
              ? error.status.errorMessage
              : 'Failed to load trending coins',
        ),
      );
      return;
    }

    // All successful - emit success state
    emit(
      PortfolioSuccess(
        balance: (balanceResult as ApiSuccess).data,
        coins: (coinsResult as ApiSuccess).data,
        trendingCoins: (trendingResult as ApiSuccess).data,
      ),
    );
  }

  /// Refresh portfolio data
  Future<void> refreshPortfolio() async {
    await loadPortfolio();
  }
}
