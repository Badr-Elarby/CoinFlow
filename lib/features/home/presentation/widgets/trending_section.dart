import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/constants/assets_paths.dart';
import 'package:team_7/core/networking/error_view.dart';
import 'package:team_7/features/home/presentation/cubit/trending/trending_cubit.dart';
import 'package:team_7/features/home/presentation/cubit/trending/trending_state.dart';
import 'package:team_7/features/home/presentation/widgets/trending_now.dart';

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingCubit, TrendingState>(
      builder: (context, state) {
        return switch (state) {
          TrendingInitial() => const SizedBox.shrink(),
          TrendingLoading() => const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          TrendingError(:final error) => ErrorView(
            error: error.errorMessage,
            onPressed: () => context.read<TrendingCubit>().fetchTrendingCoins(),
            imagePath: '${AssetsPaths.imagePath}error.png',
          ),
          TrendingSuccess(:final coins) => TrendingNow(coins: coins),
        };
      },
    );
  }
}
