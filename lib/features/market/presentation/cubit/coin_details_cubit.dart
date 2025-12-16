import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/networking/api_error_model.dart';
import 'package:team_7/core/shared/common_layers/domain/repository/home_repo.dart';
import 'package:team_7/features/market/data/models/coin_details_model.dart';

part 'coin_details_state.dart';

class CoinDetailsCubit extends Cubit<CoinDetailsState> {
  final HomeRepo _homeRepo;

  CoinDetailsCubit(this._homeRepo) : super(CoinDetailsInitial());

  Future<void> getCoinDetails(String coinId) async {
    emit(CoinDetailsLoading());

    final result = await _homeRepo.getCoinDetails(coinId);

    result.when(
      onSuccess: (coinDetails) {
        emit(CoinDetailsLoaded(coinDetails: coinDetails));
        // Fetch market chart data after getting coin details
        getMarketChart(coinId);
      },
      onError: (error) {
        emit(CoinDetailsError(error));
      },
    );
  }

  Future<void> getMarketChart(String coinId, {int days = 7}) async {
    if (state is! CoinDetailsLoaded) return;

    final currentState = state as CoinDetailsLoaded;
    
    final result = await _homeRepo.getMarketChart(coinId, days: days);

    result.when(
      onSuccess: (chartData) {
        emit(CoinDetailsLoaded(
          coinDetails: currentState.coinDetails,
          chartData: chartData,
          selectedDays: days,
        ));
      },
      onError: (error) {
        // Keep existing state but with error for chart
        emit(CoinDetailsLoaded(
          coinDetails: currentState.coinDetails,
          chartData: currentState.chartData,
          selectedDays: currentState.selectedDays,
        ));
      },
    );
  }

  void changeTimeRange(String coinId, int days) {
    if (state is! CoinDetailsLoaded) return;
    getMarketChart(coinId, days: days);
  }
}

