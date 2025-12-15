import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/features/coin_details/data/model/coin_details_model.dart';
import 'package:team_7/features/coin_details/data/model/market_chart_response.dart';
import 'package:team_7/features/coin_details/domain/repository/coin_details_repo.dart';

part 'coin_details_state.dart';

class CoinDetailsCubit extends Cubit<CoinDetailsState> {
  final CoinDetailsRepo _coinDetailsRepo;

  CoinDetailsCubit(this._coinDetailsRepo) : super(CoinDetailsInitial());

  Future<void> getCoinDetails(String coinId) async {
    emit(CoinDetailsLoading());

    try {
      final coinDetails = await _coinDetailsRepo.getCoinDetails(coinId);
      emit(CoinDetailsLoaded(
        coinDetails: coinDetails,
        chartData: [],
        selectedDays: '7',
      ));
      // Fetch chart data after getting coin details
      await getChartData(coinId, '7');
    } catch (e) {
      emit(CoinDetailsError(e.toString()));
    }
  }

  Future<void> getChartData(String coinId, String days) async {
    if (state is! CoinDetailsLoaded) return;

    final currentState = state as CoinDetailsLoaded;

    try {
      final chartData = await _coinDetailsRepo.getChartData(coinId, days);
      emit(CoinDetailsLoaded(
        coinDetails: currentState.coinDetails,
        chartData: chartData,
        selectedDays: days,
      ));
    } catch (e) {
      // Keep existing state but without chart data
      emit(CoinDetailsLoaded(
        coinDetails: currentState.coinDetails,
        chartData: currentState.chartData,
        selectedDays: currentState.selectedDays,
      ));
    }
  }

  void changeTimeRange(String coinId, String days) {
    if (state is! CoinDetailsLoaded) return;
    getChartData(coinId, days);
  }
}

