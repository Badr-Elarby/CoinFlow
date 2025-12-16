import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/di/dependency_injection.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/features/coin_details/presentation/cubit/coin_details_cubit.dart';
import 'package:team_7/features/coin_details/presentation/widgets/coin_details_body.dart';
import 'package:team_7/features/coin_details/presentation/widgets/coin_details_loading.dart';
import 'package:team_7/features/coin_details/presentation/widgets/coin_details_error.dart';

class CoinDetailsScreen extends StatelessWidget {
  final String coinId;
  final String? coinName;
  final String? coinImage;

  const CoinDetailsScreen({
    super.key,
    required this.coinId,
    this.coinName,
    this.coinImage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CoinDetailsCubit>()..getCoinDetails(coinId),
      child: Scaffold(
        backgroundColor: context.background,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: BlocBuilder<CoinDetailsCubit, CoinDetailsState>(
                  builder: (context, state) {
                    return switch (state) {
                      CoinDetailsLoading() => const CoinDetailsLoadingWidget(),
                      CoinDetailsError() => CoinDetailsErrorWidget(
                          message: state.message,
                          onRetry: () => context
                              .read<CoinDetailsCubit>()
                              .getCoinDetails(coinId),
                        ),
                      CoinDetailsLoaded() => CoinDetailsBody(
                          coinDetails: state.coinDetails,
                          chartData: state.chartData,
                          selectedDays: state.selectedDays,
                          coinId: coinId,
                        ),
                      _ => const SizedBox.shrink(),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.outline.withAlpha(51),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: context.onSurface,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Coin Details',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: context.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

