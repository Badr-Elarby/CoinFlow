part of 'search_cubit.dart';

sealed class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchActive extends SearchState {
  final List<MarketCoinModel> filteredCoins;
  final String query;

  SearchActive({
    required this.filteredCoins,
    required this.query,
  });
}

class SearchCleared extends SearchState {}

class SearchError extends SearchState {
  final ApiErrorModel error;

  SearchError(this.error);
}

