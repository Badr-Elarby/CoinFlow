import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_7/core/networking/dio_factory.dart';
import 'package:team_7/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:team_7/features/auth/data/sources/auth_data_source_impl.dart';
import 'package:team_7/features/auth/domain/repository/auth_data_source.dart';
import 'package:team_7/features/auth/domain/repository/auth_repo.dart';
import 'package:team_7/features/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:team_7/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:team_7/features/portfolio/data/datasources/portfolio_remote_data_source_impl.dart';
import 'package:team_7/features/portfolio/data/repositories/portfolio_repository.dart';
import 'package:team_7/features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:team_7/features/portfolio/presentation/cubits/portfolio_cubit/portfolio_cubit.dart';

final getIt = GetIt.instance;

/// Setup dependency injection for the entire app
///
/// Architecture:
/// - Core services (Dio, SharedPreferences, FirebaseAuth) are singletons
/// - DataSources and Repositories are lazy singletons (created once, reused)
/// - Cubits are factories (new instance each time, proper lifecycle)
Future<void> setupGetIt() async {
  // ========================================
  // Core Services
  // ========================================

  /// Single Dio instance for all HTTP networking
  /// Configured with interceptors via DioFactory
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());

  /// Single FirebaseAuth instance for all authentication
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  /// SharedPreferences for local storage
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // ========================================
  // Auth Feature
  // ========================================

  // Data Sources
  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(getIt<FirebaseAuth>()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(getIt<AuthDataSource>()),
  );

  // Cubits (Factory registration for proper lifecycle)
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt<AuthRepo>()));

  // ========================================
  // Portfolio Feature
  // ========================================

  // Data Sources (receives Dio via constructor injection)
  getIt.registerLazySingleton<PortfolioRemoteDataSource>(
    () => PortfolioRemoteDataSourceImpl(getIt<Dio>()),
  );

  // Repositories
  getIt.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(getIt<PortfolioRemoteDataSource>()),
  );

  // Cubits (Factory registration for proper lifecycle)
  getIt.registerFactory<PortfolioCubit>(
    () => PortfolioCubit(getIt<PortfolioRepository>()),
  );
}
