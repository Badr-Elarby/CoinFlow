part of 'coin_details_cubit.dart';

sealed class CoinDetailsState {}

class CoinDetailsInitial extends CoinDetailsState {}

class CoinDetailsLoading extends CoinDetailsState {}

class CoinDetailsLoaded extends CoinDetailsState {
  final CoinDetailsModel coinDetails;
  final List<List<double>>? chartData;
  final int selectedDays;

  CoinDetailsLoaded({
    required this.coinDetails,
    this.chartData,
    this.selectedDays = 7,
  });
}

class CoinDetailsError extends CoinDetailsState {
  final ApiErrorModel error;

  CoinDetailsError(this.error);
}

