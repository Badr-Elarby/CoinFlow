import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_7/core/di/dependency_injection.dart';
import 'package:team_7/core/helpers/shared_pref_helper.dart';
import 'package:team_7/core/routing/routes.dart';
import 'package:team_7/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:team_7/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:team_7/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:team_7/features/coin_details/presentation/screens/coin_details_screen.dart';
import 'package:team_7/features/home/presentation/cubit/global_data/global_data_cubit.dart';
import 'package:team_7/features/home/presentation/cubit/market/market_cubit.dart';
import 'package:team_7/features/home/presentation/cubit/trending/trending_cubit.dart';
import 'package:team_7/features/home/presentation/pages/home_screen.dart';
import 'package:team_7/features/market/presentation/screens/market_screen.dart';
import 'package:team_7/features/portfolio/presentation/cubits/portfolio_cubit/portfolio_cubit.dart';
import 'package:team_7/features/portfolio/presentation/screens/portfolio_screen.dart';
import 'package:team_7/features/splash/presentation/screens/splash_screen.dart';
import 'package:team_7/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:team_7/features/settings/presentation/screens/settings_screen.dart';
import 'package:team_7/features/buy_crypto/presentation/screen/buy_crypto_screen.dart';
import 'package:team_7/features/buy_crypto/presentation/screen/payment_method_screen.dart';
import 'package:team_7/core/shared_widgets/custom_bottom_nav_bar.dart';

class AppRouter {
  AppRouter._();
  static final AuthCubit authCubit = getIt<AuthCubit>();

  static final GoRouter router = GoRouter(
    initialLocation: Routes.homeRoute,

    redirect: (context, state) async {
      final path = state.uri.path;

      if (path == Routes.splashRoute) {
        return null;
      }

      final onboardingCompleted = await SharedPrefHelper.getBool(
        Routes.onboardingCompletedKey,
      );

      if (!onboardingCompleted) {
        return Routes.onboardingRoute;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: Routes.splashRoute,
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const SplashScreen()),
      ),
      GoRoute(
        path: Routes.onboardingRoute,
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const OnboardingScreen()),
      ),
      GoRoute(
        path: Routes.signInRoute,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: BlocProvider.value(
            value: authCubit,
            child: const SignInScreen(),
          ),
        ),
      ),
      GoRoute(
        path: Routes.signUpRoute,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: BlocProvider.value(
            value: authCubit,
            child: const SignUpScreen(),
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: CustomBottomNavBar(
              navigationShell: navigationShell,
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.homeRoute,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) =>
                            getIt<GlobalDataCubit>()..fetchGlobalData(),
                      ),
                      BlocProvider(
                        create: (_) =>
                            getIt<TrendingCubit>()..fetchTrendingCoins(),
                      ),
                      BlocProvider(
                        create: (_) => getIt<MarketCubit>()..fetchMarketCoins(),
                      ),
                    ],
                    child: const HomeScreen(),
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.marketRoute,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const MarketScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.portfolioRoute,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: BlocProvider(
                    create: (context) =>
                        getIt<PortfolioCubit>()..loadPortfolio(),
                    child: const PortfolioScreen(),
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.settingsRoute,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const SettingsScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.searchRoute,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: CoinDetailsScreen(coinId: state.extra as String),
        ),
      ),
      GoRoute(
        path: Routes.buyCryptoRoute,
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const BuyCryptoScreen()),
      ),
      GoRoute(
        path: Routes.paymentMethodRoute,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const PaymentMethodScreen(),
        ),
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Route not found: ${state.uri.path}')),
    ),
  );

  static Future<void> completeOnboarding() async {
    await SharedPrefHelper.setData(Routes.onboardingCompletedKey, true);
  }
}
