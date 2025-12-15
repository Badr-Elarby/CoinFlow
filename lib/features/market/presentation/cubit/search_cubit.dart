import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/networking/api_error_model.dart';
import 'package:team_7/core/shared/common_layers/data/model/market_coin_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  void searchCoins(String query, List<MarketCoinModel> allCoins) {
    final trimmedQuery = query.trim().toLowerCase();

    if (trimmedQuery.isEmpty) {
      emit(SearchCleared());
      return;
    }

    emit(SearchLoading());

    final filteredCoins = allCoins.where((coin) {
      final name = coin.name?.toLowerCase() ?? '';
      return name.contains(trimmedQuery);
    }).toList();

    emit(SearchActive(
      filteredCoins: filteredCoins,
      query: query,
    ));
  }

  void clearSearch() {
    emit(SearchCleared());
  }
}

