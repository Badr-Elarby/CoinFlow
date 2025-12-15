import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/di/injection_container.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/core/theming/app_text.dart';
import 'package:team_7/core/responsive/app_spacing.dart';
import 'package:team_7/features/portfolio/presentation/cubits/portfolio_cubit/portfolio_cubit.dart';
import 'package:team_7/features/portfolio/presentation/cubits/portfolio_cubit/portfolio_state.dart';
import 'package:team_7/features/portfolio/presentation/widgets/total_value_card.dart';
import 'package:team_7/features/portfolio/presentation/widgets/month_selector.dart';
import 'package:team_7/features/portfolio/presentation/widgets/portfolio_chart.dart';
import 'package:team_7/features/portfolio/presentation/widgets/holdings_list.dart';
import 'package:team_7/features/portfolio/presentation/widgets/trending_coins_list.dart';
import 'package:team_7/features/portfolio/presentation/widgets/section_header.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PortfolioCubit>()..loadPortfolio(),
      child: Scaffold(
        backgroundColor: context.background,
        body: SafeArea(
          child: BlocBuilder<PortfolioCubit, PortfolioState>(
            builder: (context, state) {
              if (state is PortfolioLoading) {
                return Center(
                  child: CircularProgressIndicator(color: context.primary),
                );
              }

              if (state is PortfolioError) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(context.wp(4)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: context.error,
                        ),
                        AppSpacing.h16,
                        Text(
                          'Error Loading Portfolio',
                          style: AppText.white18Medium.copyWith(
                            color: context.onSurface,
                          ),
                        ),
                        AppSpacing.h8,
                        Text(
                          state.message,
                          style: AppText.gray12Regular.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        AppSpacing.h24,
                        ElevatedButton(
                          onPressed: () {
                            context.read<PortfolioCubit>().refreshPortfolio();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state is PortfolioSuccess) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await context.read<PortfolioCubit>().refreshPortfolio();
                  },
                  color: context.primary,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.wp(4),
                      vertical: context.hp(2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          'Portfolio',
                          style: AppText.white28Bold.copyWith(
                            color: context.onSurface,
                          ),
                        ),
                        AppSpacing.h24,

                        // Total Value Card - with real data
                        TotalValueCard(balance: state.balance),
                        AppSpacing.h24,

                        // Month Selector
                        const MonthSelector(),
                        AppSpacing.h24,

                        // Portfolio Chart - with real data
                        PortfolioChart(balance: state.balance),
                        AppSpacing.h24,

                        // My Holdings Section - with real data
                        const SectionHeader(title: 'My Holdings'),
                        AppSpacing.h16,
                        HoldingsList(
                          balance: state.balance,
                          coins: state.coins,
                        ),
                        AppSpacing.h24,

                        // Trending Coins Section
                        const SectionHeader(title: 'Trending Coins'),
                        AppSpacing.h16,
                        TrendingCoinsList(coins: state.trendingCoins),
                        AppSpacing.h24,
                      ],
                    ),
                  ),
                );
              }

              // Initial state
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
