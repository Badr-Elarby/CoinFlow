import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/networking/api_error_model.dart';
import 'package:team_7/core/shared/common_layers/data/model/market_coin_model.dart';
import 'package:team_7/core/shared/common_layers/domain/repository/home_repo.dart';

part 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  final HomeRepo _homeRepo;

  MarketCubit(this._homeRepo) : super(MarketInitial());

  Future<void> getMarketCoins() async {
    final currentCoins = state is MarketLoaded
        ? (state as MarketLoaded).coins
        : <MarketCoinModel>[];

    emit(MarketLoading(coins: currentCoins));

    final result = await _homeRepo.getMarketCoins();

    result.when(
      onSuccess: (coins) {
        emit(MarketLoaded(coins: coins));
      },
      onError: (error) {
        emit(MarketError(error));
      },
    );
  }
}
