import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:team_7/core/app_cubit/app_cubit.dart';
import 'package:team_7/core/networking/api_consumer.dart';
import 'package:team_7/core/networking/dio_consumer.dart';
import 'package:team_7/core/networking/dio_factory.dart';
// Shared/common layers for market feature
import 'package:team_7/core/shared/common_layers/data/repository/home_repo_impl.dart'
    as shared;
import 'package:team_7/core/shared/common_layers/data/sources/home_data_source_impl.dart'
    as shared;
import 'package:team_7/core/shared/common_layers/domain/repository/home_data_source.dart'
    as shared;
import 'package:team_7/core/shared/common_layers/domain/repository/home_repo.dart'
    as shared;
// Home feature specific
import 'package:team_7/features/home/data/repository/home_data_source_impl.dart'
    as home;
import 'package:team_7/features/home/data/repository/home_repo_impl.dart'
    as home;
import 'package:team_7/features/home/domain/repository/home_data_source.dart'
    as home;
import 'package:team_7/features/home/domain/repository/home_repo.dart' as home;
import 'package:team_7/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:team_7/features/auth/data/sources/auth_data_source_impl.dart';
import 'package:team_7/features/auth/domain/repository/auth_data_source.dart';
import 'package:team_7/features/auth/domain/repository/auth_repo.dart';
import 'package:team_7/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:team_7/features/buy_crypto/data/repository/buy_crypto_repo_impl.dart';
import 'package:team_7/features/buy_crypto/data/sources/buy_crypto_data_source_impl.dart';
import 'package:team_7/features/buy_crypto/domain/repository/buy_crypto_data_source.dart';
import 'package:team_7/features/buy_crypto/domain/repository/buy_crypto_repo.dart';
import 'package:team_7/features/buy_crypto/presentation/cubit/buy_crypto_cubit.dart';
import 'package:team_7/features/coin_details/data/repository/coin_repository_impl.dart';
import 'package:team_7/features/coin_details/data/source/coin_details_data_source.dart';
import 'package:team_7/features/coin_details/domain/repository/coin_details_repo.dart';
import 'package:team_7/features/coin_details/presentation/cubit/coin_details_cubit.dart';
import 'package:team_7/features/home/presentation/cubit/global_data/global_data_cubit.dart';
import 'package:team_7/features/home/presentation/cubit/market/market_cubit.dart';
import 'package:team_7/features/home/presentation/cubit/trending/trending_cubit.dart';
import 'package:team_7/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:team_7/features/portfolio/data/datasources/portfolio_remote_data_source_impl.dart';
import 'package:team_7/features/portfolio/data/repositories/portfolio_repository.dart';
import 'package:team_7/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:team_7/features/portfolio/presentation/cubits/portfolio_cubit/portfolio_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  //firebase auth
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //dio
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: dio));

  //auth
  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(firebaseAuth),
  );
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
  //api consumer

  //home feature
  getIt.registerLazySingleton<home.HomeDataSource>(
    () => home.HomeDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<home.HomeRepo>(
    () => home.HomeRepoImpl(getIt<home.HomeDataSource>()),
  );
  getIt.registerFactory<GlobalDataCubit>(
    () => GlobalDataCubit(getIt<home.HomeRepo>()),
  );
  getIt.registerFactory<TrendingCubit>(
    () => TrendingCubit(getIt<home.HomeRepo>()),
  );
  getIt.registerFactory<MarketCubit>(() => MarketCubit(getIt<home.HomeRepo>()));

  //shared home repo (for market feature)
  getIt.registerLazySingleton<shared.HomeDataSource>(
    () => shared.HomeDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<shared.HomeRepo>(
    () => shared.HomeRepoImpl(getIt<shared.HomeDataSource>()),
  );
  //coin details feature
  getIt.registerLazySingleton<CoinDetailsDataSourceBase>(
    () => CoinDetailsDataSource(apiConsumer: getIt()),
  );
  getIt.registerLazySingleton<CoinDetailsRepo>(
    () => CoinRepositoryImpl(getIt()),
  );
  getIt.registerFactory<CoinDetailsCubit>(() => CoinDetailsCubit(getIt()));

  //buy crypto feature
  getIt.registerLazySingleton<BuyCryptoDataSource>(
    () => BuyCryptoDataSourceImpl(apiConsumer: getIt()),
  );
  getIt.registerLazySingleton<BuyCryptoRepo>(() => BuyCryptoRepoImpl(getIt()));
  getIt.registerFactory<BuyCryptoCubit>(() => BuyCryptoCubit(getIt()));

  //portfolio feature
  getIt.registerLazySingleton<PortfolioRemoteDataSource>(
    () => PortfolioRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(getIt<PortfolioRemoteDataSource>()),
  );

  getIt.registerFactory<PortfolioCubit>(
    () => PortfolioCubit(getIt<PortfolioRepository>()),
  );
  //app cubit
  getIt.registerLazySingleton<AppCubit>(() => AppCubit());
}
