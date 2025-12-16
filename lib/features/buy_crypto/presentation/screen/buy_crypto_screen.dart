import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_7/core/routing/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/di/dependency_injection.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/core/shared_widgets/custom_button.dart';
import 'package:team_7/features/buy_crypto/data/models/simple_price_model.dart';
import 'package:team_7/features/buy_crypto/presentation/cubit/buy_crypto_cubit.dart';
import 'package:team_7/features/buy_crypto/presentation/cubit/buy_crypto_state.dart';
import 'package:team_7/features/buy_crypto/presentation/widgets/currency_input_card.dart';
import 'package:team_7/features/buy_crypto/presentation/widgets/exchange_fee_card.dart';

class BuyCryptoScreen extends StatelessWidget {
  const BuyCryptoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BuyCryptoCubit>()
        ..fetchPrice(
          cryptoId: 'ethereum',
          cryptoSymbol: 'ETH',
          initialPayAmount: 1800.0,
        ),
      child: const _BuyCryptoScreenContent(),
    );
  }
}

class _BuyCryptoScreenContent extends StatefulWidget {
  const _BuyCryptoScreenContent();

  @override
  State<_BuyCryptoScreenContent> createState() =>
      _BuyCryptoScreenContentState();
}

class _BuyCryptoScreenContentState extends State<_BuyCryptoScreenContent> {
  final TextEditingController _payController = TextEditingController(
    text: '1,800.00',
  );
  final TextEditingController _receiveController = TextEditingController();

  @override
  void dispose() {
    _payController.dispose();
    _receiveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(
        backgroundColor: context.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppExtraColors.navyBlue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Buy Crypto',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppExtraColors.navyBlue,
          ),
        ),
      ),
      body: BlocConsumer<BuyCryptoCubit, BuyCryptoState>(
        listener: (context, state) {
          if (state is BuyCryptoPriceLoaded) {
            _receiveController.text = state.receiveAmount.toStringAsFixed(4);
          }
          if (state is BuyCryptoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppExtraColors.danger,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is BuyCryptoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BuyCryptoPriceLoaded) {
            return _buildContent(context, state);
          }

          if (state is BuyCryptoError) {
            return _buildError(context, state.message);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, BuyCryptoPriceLoaded state) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Input Section Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: context.outline.withAlpha(20),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // You Pay Section
                  CurrencyInputCard(
                    label: 'You Pay',
                    controller: _payController,
                    currency: state.payCurrency,
                    currencyIcon: _getCurrencyIcon(state.payCurrency),
                    onCurrencyTap: () => _showFiatPicker(context),
                    isFiat: true,
                    onChanged: (value) {
                      context.read<BuyCryptoCubit>().updatePayAmountFromText(
                        value,
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Swap Button
                  _buildSwapButton(context),

                  const SizedBox(height: 16),

                  // You Receive Section
                  CurrencyInputCard(
                    label: 'You Receive',
                    controller: _receiveController,
                    currency: state.receiveCurrency,
                    currencyIcon: _getCurrencyIcon(state.receiveCurrency),
                    onCurrencyTap: () => _showCryptoPicker(context, state),
                    isFiat: false,
                    readOnly: true,
                  ),

                  const SizedBox(height: 20),

                  // Exchange Rate
                  _buildExchangeRate(state),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Exchange Fee Card
            ExchangeFeeCard(
              feePercent: state.feePercent,
              feeAmount: state.feeAmount,
            ),

            const Spacer(),

            // Continue Button
            CustomButton(
              text: 'Continue',
              onPressed: () {
                // _onContinue(context, state); // Original Logic
                context.push(Routes.paymentMethodRoute);
              },
              width: double.infinity,
              height: 56,
              backgroundColor: AppExtraColors.navyBlue,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppExtraColors.danger),
          const SizedBox(height: 16),
          Text(
            'Failed to load prices',
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: GoogleFonts.lato(
              fontSize: 14,
              color: AppExtraColors.paleSky,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<BuyCryptoCubit>().fetchPrice(
                cryptoId: 'ethereum',
                cryptoSymbol: 'ETH',
              );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildSwapButton(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: context.background,
        shape: BoxShape.circle,
        border: Border.all(color: context.outline.withAlpha(50), width: 1),
      ),
      child: Icon(Icons.swap_vert, color: AppExtraColors.warning, size: 22),
    );
  }

  Widget _buildExchangeRate(BuyCryptoPriceLoaded state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: AppExtraColors.warning,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '1 ${state.payCurrency} = ${state.exchangeRate.toStringAsFixed(8)} ${state.receiveCurrency}',
          style: GoogleFonts.lato(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppExtraColors.paleSky,
          ),
        ),
      ],
    );
  }

  Widget _getCurrencyIcon(String currency) {
    switch (currency.toUpperCase()) {
      case 'USD':
        return Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppExtraColors.navyBlue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '\$',
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        );
      case 'ETH':
        return Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Color(0xFF627EEA),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.change_history, color: Colors.white, size: 14),
          ),
        );
      case 'BTC':
        return Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Color(0xFFF7931A),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '₿',
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        );
      case 'SOL':
        return Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9945FF), Color(0xFF14F195)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'S',
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        );
      case 'USDT':
        return Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Color(0xFF26A17B),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '₮',
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        );
      default:
        return Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppExtraColors.gray,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              currency.isNotEmpty ? currency[0] : '?',
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        );
    }
  }

  void _showFiatPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Currency',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: context.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            ...CryptoCurrency.fiatCurrencies.map(
              (currency) => ListTile(
                leading: _getCurrencyIcon(currency.symbol),
                title: Text(
                  currency.name,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.onSurface,
                  ),
                ),
                subtitle: Text(
                  currency.symbol,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: AppExtraColors.paleSky,
                  ),
                ),
                onTap: () => Navigator.pop(ctx),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showCryptoPicker(BuildContext context, BuyCryptoPriceLoaded state) {
    final cubit = context.read<BuyCryptoCubit>();

    showModalBottomSheet(
      context: context,
      backgroundColor: context.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Cryptocurrency',
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: context.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            ...CryptoCurrency.popularCryptos.map(
              (crypto) => ListTile(
                leading: _getCurrencyIcon(crypto.symbol),
                title: Text(
                  crypto.name,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: context.onSurface,
                  ),
                ),
                subtitle: Text(
                  crypto.symbol,
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: AppExtraColors.paleSky,
                  ),
                ),
                trailing: state.receiveCryptoId == crypto.id
                    ? Icon(Icons.check, color: AppExtraColors.success)
                    : null,
                onTap: () {
                  cubit.changeCrypto(
                    cryptoId: crypto.id,
                    cryptoSymbol: crypto.symbol,
                  );
                  Navigator.pop(ctx);
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _onContinue(BuildContext context, BuyCryptoPriceLoaded state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Processing purchase of ${state.receiveAmount.toStringAsFixed(4)} ${state.receiveCurrency} for \$${state.payAmount.toStringAsFixed(2)}',
          style: GoogleFonts.lato(fontWeight: FontWeight.w500),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
