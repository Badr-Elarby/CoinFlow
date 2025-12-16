import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/features/home/domain/repository/home_repo.dart';
import 'package:team_7/features/home/presentation/cubit/global_data/global_data_state.dart';

class GlobalDataCubit extends Cubit<GlobalDataState> {
  final HomeRepo _homeRepo;

  GlobalDataCubit(this._homeRepo) : super(GlobalDataInitial());

  Future<void> fetchGlobalData() async {
    emit(GlobalDataLoading());
    final result = await _homeRepo.getGlobalData();
    result.when(
      onSuccess: (data) => emit(GlobalDataSuccess(data)),
      onError: (error) => emit(GlobalDataError(error)),
    );
  }
}




