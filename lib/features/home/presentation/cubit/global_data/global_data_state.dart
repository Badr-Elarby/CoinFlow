import 'package:team_7/core/networking/api_error_model.dart';
import 'package:team_7/features/home/data/model/global_data_model.dart';

sealed class GlobalDataState {}

final class GlobalDataInitial extends GlobalDataState {}

final class GlobalDataLoading extends GlobalDataState {}

final class GlobalDataSuccess extends GlobalDataState {
  final GlobalDataModel data;
  GlobalDataSuccess(this.data);
}

final class GlobalDataError extends GlobalDataState {
  final ApiErrorModel error;
  GlobalDataError(this.error);
}
