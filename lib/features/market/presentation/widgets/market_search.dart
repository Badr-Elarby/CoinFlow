import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/features/market/presentation/cubit/market_cubit.dart';
import 'package:team_7/features/market/presentation/cubit/search_cubit.dart';
import 'package:team_7/features/market/presentation/widgets/market_search_bar.dart';

class MarketSearch extends StatelessWidget {
  const MarketSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MarketSearchBar(
            onChanged: (query) {
              final marketState = context.read<MarketCubit>().state;
              if (marketState is MarketLoaded) {
                context.read<SearchCubit>().searchCoins(query, marketState.coins);
              }
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}