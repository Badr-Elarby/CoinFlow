import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/features/home/domain/repository/home_repo.dart';
import 'package:team_7/features/home/presentation/cubit/market/market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  final HomeRepo _homeRepo;

  MarketCubit(this._homeRepo) : super(MarketInitial());

  Future<void> fetchMarketCoins() async {
    emit(MarketLoading());
    final result = await _homeRepo.getMarketCoins();
    result.when(
      onSuccess: (data) => emit(MarketSuccess(data)),
      onError: (error) => emit(MarketError(error)),
    );
  }
}
