import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:team_7/core/app_cubit/app_cubit.dart';
import 'package:team_7/core/networking/api_consumer.dart';
import 'package:team_7/core/networking/dio_consumer.dart';
import 'package:team_7/core/networking/dio_factory.dart';

import 'package:team_7/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:team_7/features/auth/data/sources/auth_data_source_impl.dart';
import 'package:team_7/features/auth/domain/repository/auth_data_source.dart';
import 'package:team_7/features/auth/domain/repository/auth_repo.dart';
import 'package:team_7/features/auth/presentation/cubit/auth_cubit.dart';

// Home Feature
import 'package:team_7/features/home/data/repository/home_data_source_impl.dart'
    as home_impl;
import 'package:team_7/features/home/data/repository/home_repo_impl.dart'
    as home_impl;
import 'package:team_7/features/home/domain/repository/home_data_source.dart'
    as home_domain;
import 'package:team_7/features/home/domain/repository/home_repo.dart'
    as home_domain;
import 'package:team_7/features/home/presentation/cubit/global_data/global_data_cubit.dart';
import 'package:team_7/features/home/presentation/cubit/market/market_cubit.dart'
    as home_cubit;
import 'package:team_7/features/home/presentation/cubit/trending/trending_cubit.dart';

import 'package:team_7/core/shared/common_layers/data/repository/home_repo_impl.dart'
    as market_impl;
import 'package:team_7/core/shared/common_layers/data/sources/home_data_source_impl.dart'
    as market_impl;
import 'package:team_7/core/shared/common_layers/domain/repository/home_data_source.dart'
    as market_domain;
import 'package:team_7/core/shared/common_layers/domain/repository/home_repo.dart'
    as market_domain;
import 'package:team_7/features/market/presentation/cubit/market_cubit.dart'
    as market_cubit;
import 'package:team_7/features/market/presentation/cubit/search_cubit.dart';

// Coin Details Feature
import 'package:team_7/features/coin_details/data/repository/coin_repository_impl.dart';
import 'package:team_7/features/coin_details/data/source/coin_details_data_source.dart';
import 'package:team_7/features/coin_details/domain/repository/coin_details_repo.dart';
import 'package:team_7/features/coin_details/presentation/cubit/coin_details_cubit.dart';

// Buy Crypto Feature
import 'package:team_7/features/buy_crypto/data/repository/buy_crypto_repo_impl.dart';
import 'package:team_7/features/buy_crypto/data/sources/buy_crypto_data_source_impl.dart';
import 'package:team_7/features/buy_crypto/domain/repository/buy_crypto_data_source.dart';
import 'package:team_7/features/buy_crypto/domain/repository/buy_crypto_repo.dart';
import 'package:team_7/features/buy_crypto/presentation/cubit/buy_crypto_cubit.dart';

// Portfolio Feature
import 'package:team_7/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:team_7/features/portfolio/data/datasources/portfolio_remote_data_source_impl.dart';
import 'package:team_7/features/portfolio/data/repositories/portfolio_repository.dart';
import 'package:team_7/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:team_7/features/portfolio/presentation/cubits/portfolio_cubit/portfolio_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final dio = DioFactory.getDio();
  final firebaseAuth = FirebaseAuth.instance;

  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: dio));

  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(firebaseAuth),
  );
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getIt()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));

  getIt.registerLazySingleton<home_domain.HomeDataSource>(
    () => home_impl.HomeDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<home_domain.HomeRepo>(
    () => home_impl.HomeRepoImpl(getIt<home_domain.HomeDataSource>()),
  );
  getIt.registerFactory<GlobalDataCubit>(
    () => GlobalDataCubit(getIt<home_domain.HomeRepo>()),
  );
  getIt.registerFactory<TrendingCubit>(
    () => TrendingCubit(getIt<home_domain.HomeRepo>()),
  );
  getIt.registerFactory<home_cubit.MarketCubit>(
    () => home_cubit.MarketCubit(getIt<home_domain.HomeRepo>()),
  );

  getIt.registerLazySingleton<market_domain.HomeDataSource>(
    () => market_impl.HomeDataSourceImpl(apiConsumer: getIt<ApiConsumer>()),
  );
  getIt.registerLazySingleton<market_domain.HomeRepo>(
    () => market_impl.HomeRepoImpl(getIt<market_domain.HomeDataSource>()),
  );
  getIt.registerFactory<market_cubit.MarketCubit>(
    () => market_cubit.MarketCubit(getIt<market_domain.HomeRepo>()),
  );
  getIt.registerFactory<SearchCubit>(() => SearchCubit());

  getIt.registerLazySingleton<CoinDetailsDataSourceBase>(
    () => CoinDetailsDataSource(apiConsumer: getIt()),
  );
  getIt.registerLazySingleton<CoinDetailsRepo>(
    () => CoinRepositoryImpl(getIt()),
  );
  getIt.registerFactory<CoinDetailsCubit>(() => CoinDetailsCubit(getIt()));

  getIt.registerLazySingleton<BuyCryptoDataSource>(
    () => BuyCryptoDataSourceImpl(apiConsumer: getIt()),
  );
  getIt.registerLazySingleton<BuyCryptoRepo>(() => BuyCryptoRepoImpl(getIt()));
  getIt.registerFactory<BuyCryptoCubit>(() => BuyCryptoCubit(getIt()));

  getIt.registerLazySingleton<PortfolioRemoteDataSource>(
    () => PortfolioRemoteDataSourceImpl(getIt<Dio>()),
  );
  getIt.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(getIt<PortfolioRemoteDataSource>()),
  );
  getIt.registerFactory<PortfolioCubit>(
    () => PortfolioCubit(getIt<PortfolioRepository>()),
  );
  getIt.registerLazySingleton<AppCubit>(() => AppCubit());
}
