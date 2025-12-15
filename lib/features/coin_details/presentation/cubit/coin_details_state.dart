part of 'coin_details_cubit.dart';

sealed class CoinDetailsState {}

class CoinDetailsInitial extends CoinDetailsState {}

class CoinDetailsLoading extends CoinDetailsState {}

class CoinDetailsLoaded extends CoinDetailsState {
  final CoinDetailsModel coinDetails;
  final List<ChartDataPoint> chartData;
  final String selectedDays;

  CoinDetailsLoaded({
    required this.coinDetails,
    required this.chartData,
    required this.selectedDays,
  });
}

class CoinDetailsError extends CoinDetailsState {
  final String message;

  CoinDetailsError(this.message);
}

