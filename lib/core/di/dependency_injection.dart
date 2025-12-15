import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:team_7/core/networking/api_consumer.dart';
import 'package:team_7/core/networking/dio_consumer.dart';
import 'package:team_7/core/networking/dio_factory.dart';
import 'package:team_7/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:team_7/features/auth/data/sources/auth_data_source_impl.dart';
import 'package:team_7/features/auth/domain/repository/auth_data_source.dart';
import 'package:team_7/features/auth/domain/repository/auth_repo.dart';
import 'package:team_7/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:team_7/features/home/data/repository/home_data_source_impl.dart';
import 'package:team_7/features/home/data/repository/home_repo_impl.dart';
import 'package:team_7/features/home/domain/repository/home_data_source.dart';
import 'package:team_7/features/home/domain/repository/home_repo.dart';
import 'package:team_7/features/home/presentation/cubit/global_data/global_data_cubit.dart';
import 'package:team_7/features/home/presentation/cubit/trending/trending_cubit.dart';
import 'package:team_7/features/home/presentation/cubit/market/market_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  //firebase auth
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //dio
  Dio dio = DioFactory.getDio();

  //auth
  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(firebaseAuth),
  );
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt()));
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt()));

  //api consumer
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: dio));

  //home
  getIt.registerLazySingleton<HomeDataSource>(
    () => HomeDataSourceImpl(apiConsumer: getIt()),
  );
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(getIt()));

  // Home cubits (separate cubits for each data source)
  getIt.registerFactory<GlobalDataCubit>(() => GlobalDataCubit(getIt()));
  getIt.registerFactory<TrendingCubit>(() => TrendingCubit(getIt()));
  getIt.registerFactory<MarketCubit>(() => MarketCubit(getIt()));
}
