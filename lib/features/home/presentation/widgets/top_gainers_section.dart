import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/constants/assets_paths.dart';
import 'package:team_7/core/networking/error_view.dart';
import 'package:team_7/features/home/data/model/market_coin_model.dart';
import 'package:team_7/features/home/presentation/cubit/market/market_cubit.dart';
import 'package:team_7/features/home/presentation/cubit/market/market_state.dart';
import 'package:team_7/features/home/presentation/widgets/section_loading.dart';
import 'package:team_7/features/home/presentation/widgets/top_gainers.dart';

class TopGainersSection extends StatelessWidget {
  final Function(MarketCoinModel)? onCoinTap;

  const TopGainersSection({super.key, this.onCoinTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketCubit, MarketState>(
      builder: (context, state) {
        return switch (state) {
          MarketInitial() => const SizedBox.shrink(),
          MarketLoading() => const SectionLoading(),
          MarketError(:final error) => ErrorView(
            error: error.errorMessage,
            onPressed: () => context.read<MarketCubit>().fetchMarketCoins(),
            imagePath: '${AssetsPaths.imagePath}error.png',
          ),
          MarketSuccess(:final coins) => TopGainers(
            coins: coins,
            onCoinTap: onCoinTap,
          ),
        };
      },
    );
  }
}
