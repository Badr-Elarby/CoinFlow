import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_7/core/routing/routes.dart';
import 'package:team_7/features/market/presentation/cubit/market_cubit.dart';
import 'package:team_7/features/market/presentation/cubit/search_cubit.dart';
import 'package:team_7/features/market/presentation/widgets/market_content_list.dart';
import 'package:team_7/features/market/presentation/widgets/market_loading_state.dart';
import 'package:team_7/features/market/presentation/widgets/market_error_state.dart';
import 'package:team_7/features/market/presentation/widgets/market_empty_state.dart';

class MarketContent extends StatelessWidget {
  const MarketContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketCubit, MarketState>(
      builder: (context, marketState) {
        return switch (marketState) {
          MarketLoading() => MarketLoadingState(
            itemCount: marketState.coins.isEmpty
                ? 10
                : marketState.coins.length,
          ),
          MarketError() => MarketErrorState(
            error: marketState.error,
            onRetry: () => context.read<MarketCubit>().getMarketCoins(),
          ),
          MarketLoaded() => BlocBuilder<SearchCubit, SearchState>(
            builder: (context, searchState) {
              final coins = switch (searchState) {
                SearchActive() => searchState.filteredCoins,
                _ => marketState.coins,
              };

              if (coins.isEmpty) {
                return const MarketEmptyState();
              }

              return MarketCoinList(
                coins: coins,
                onCoinTap: (coin) {
                  context.push(Routes.homeRoute, extra: coin);
                },
              );
            },
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
