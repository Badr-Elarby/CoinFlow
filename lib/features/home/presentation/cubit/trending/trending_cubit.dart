import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/features/home/domain/repository/home_repo.dart';
import 'package:team_7/features/home/presentation/cubit/trending/trending_state.dart';

class TrendingCubit extends Cubit<TrendingState> {
  final HomeRepo _homeRepo;

  TrendingCubit(this._homeRepo) : super(TrendingInitial());

  Future<void> fetchTrendingCoins() async {
    emit(TrendingLoading());
    final result = await _homeRepo.getTrendingCoins();
    result.when(
      onSuccess: (data) => emit(TrendingSuccess(data)),
      onError: (error) => emit(TrendingError(error)),
    );
  }
}
