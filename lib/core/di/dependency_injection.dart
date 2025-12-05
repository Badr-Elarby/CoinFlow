import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:team_7/core/app_cubit/app_cubit.dart';
import 'package:team_7/core/networking/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  Dio dio = DioFactory.getDio();

  getIt.registerLazySingleton<AppCubit>(() => AppCubit());
}
