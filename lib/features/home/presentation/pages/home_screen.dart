import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/di/dependency_injection.dart';
import 'package:team_7/features/home/presentation/cubit/global_data/global_data_cubit.dart';
import 'package:team_7/features/home/presentation/cubit/market/market_cubit.dart';
import 'package:team_7/features/home/presentation/cubit/trending/trending_cubit.dart';
import 'package:team_7/features/home/presentation/widgets/balance_card.dart';
import 'package:team_7/features/home/presentation/widgets/home_header.dart';
import 'package:team_7/features/home/presentation/widgets/market_overview_section.dart';
import 'package:team_7/features/home/presentation/widgets/top_gainers_section.dart';
import 'package:team_7/features/home/presentation/widgets/trending_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<GlobalDataCubit>()..fetchGlobalData(),
        ),
        BlocProvider(
          create: (_) => getIt<TrendingCubit>()..fetchTrendingCoins(),
        ),
        BlocProvider(create: (_) => getIt<MarketCubit>()..fetchMarketCoins()),
      ],
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FE),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _refreshAll(context),
          child: const SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                HomeHeader(userName: 'Ahmed'),
                SizedBox(height: 20),
                BalanceCard(balance: '\$143,421.20'),
                SizedBox(height: 28),
                MarketOverviewSection(),
                SizedBox(height: 28),
                TrendingSection(),
                SizedBox(height: 28),
                TopGainersSection(),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refreshAll(BuildContext context) async {
    await Future.wait([
      context.read<GlobalDataCubit>().fetchGlobalData(),
      context.read<TrendingCubit>().fetchTrendingCoins(),
      context.read<MarketCubit>().fetchMarketCoins(),
    ]);
  }
}
