import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/di/dependency_injection.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/features/market/presentation/cubit/market_cubit.dart';
import 'package:team_7/features/market/presentation/cubit/search_cubit.dart';
import 'package:team_7/features/market/presentation/widgets/market_header.dart';
import 'package:team_7/features/market/presentation/widgets/market_search.dart';
import 'package:team_7/features/market/presentation/widgets/market_content.dart';

class MarketScreen extends StatelessWidget {
  const MarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<MarketCubit>()..getMarketCoins()),
        BlocProvider(create: (_) => getIt<SearchCubit>()),
      ],
      child: Scaffold(
        backgroundColor: context.background,
        body: const SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MarketHeader(),
              SizedBox(height: 16),
              MarketSearch(),
              SizedBox(height: 18),
              Expanded(child: MarketContent()),
            ],
          ),
        ),
      ),
    );
  }
}
