import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:team_7/core/networking/api_consumer.dart';
import 'package:team_7/core/networking/dio_consumer.dart';
import 'package:team_7/core/networking/dio_factory.dart';
import 'package:team_7/core/shared/common_layers/data/repository/home_repo_impl.dart';
import 'package:team_7/core/shared/common_layers/data/sources/home_data_source_impl.dart';
import 'package:team_7/core/shared/common_layers/domain/repository/home_data_source.dart';
import 'package:team_7/core/shared/common_layers/domain/repository/home_repo.dart';
import 'package:team_7/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:team_7/features/auth/data/sources/auth_data_source_impl.dart';
import 'package:team_7/features/auth/domain/repository/auth_data_source.dart';
import 'package:team_7/features/auth/domain/repository/auth_repo.dart';
import 'package:team_7/features/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:team_7/features/coin_details/data/repository/coin_repository_impl.dart';
import 'package:team_7/features/coin_details/data/source/coin_details_data_source.dart';
import 'package:team_7/features/coin_details/domain/repository/coin_details_repo.dart';
import 'package:team_7/features/coin_details/presentation/cubit/coin_details_cubit.dart';
import 'package:team_7/features/market/presentation/cubit/market_cubit.dart';
import 'package:team_7/features/market/presentation/cubit/search_cubit.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static void init() {
    // Core - Networking
    getIt.registerLazySingleton<ApiConsumer>(
      () => DioConsumer(dio: DioFactory.getDio()),
    );

    // Firebase
    getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

    // Shared Common Layers - Data Sources
    getIt.registerLazySingleton<HomeDataSource>(
      () => HomeDataSourceImpl(apiConsumer: getIt()),
    );

    // Shared Common Layers - Repositories
    getIt.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(getIt()),
    );

    // Auth - Data Sources (Firebase operations)
    getIt.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(getIt()),
    );

    // Auth - Repositories (business logic)
    getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(getIt()),
    );

    // Cubits
    getIt.registerFactory<SignUpCubit>(
      () => SignUpCubit(getIt()),
    );

    getIt.registerFactory<MarketCubit>(
      () => MarketCubit(getIt()),
    );
    getIt.registerFactory<SearchCubit>(
      () => SearchCubit(),
    );

    // Coin Details Feature - Data Sources
    getIt.registerLazySingleton<CoinDetailsDataSourceBase>(
      () => CoinDetailsDataSource(apiConsumer: getIt()),
    );

    // Coin Details Feature - Repositories
    getIt.registerLazySingleton<CoinDetailsRepo>(
      () => CoinRepositoryImpl(getIt()),
    );

    // Coin Details Feature - Cubits
    getIt.registerFactory<CoinDetailsCubit>(
      () => CoinDetailsCubit(getIt()),
    );
  }
}
