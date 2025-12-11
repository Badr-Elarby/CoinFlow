import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/constants/assets_paths.dart';
import 'package:team_7/core/networking/error_view.dart';
import 'package:team_7/features/home/presentation/cubit/global_data/global_data_cubit.dart';
import 'package:team_7/features/home/presentation/cubit/global_data/global_data_state.dart';
import 'package:team_7/features/home/presentation/widgets/market_overview.dart';
import 'package:team_7/features/home/presentation/widgets/section_loading.dart';

class MarketOverviewSection extends StatelessWidget {
  const MarketOverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalDataCubit, GlobalDataState>(
      builder: (context, state) {
        return switch (state) {
          GlobalDataInitial() => const SizedBox.shrink(),
          GlobalDataLoading() => const SectionLoading(),
          GlobalDataError(:final error) => ErrorView(
            error: error.errorMessage,
            onPressed: () => context.read<GlobalDataCubit>().fetchGlobalData(),
            imagePath: '${AssetsPaths.imagePath}error.png',
          ),
          GlobalDataSuccess(:final data) => MarketOverview(data: data),
        };
      },
    );
  }
}
