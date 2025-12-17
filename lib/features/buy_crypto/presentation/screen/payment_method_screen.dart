import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:team_7/core/shared_widgets/custom_button.dart';
import 'package:team_7/core/theming/app_colors.dart';
import 'package:team_7/core/theming/theme_extensions.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      appBar: AppBar(
        backgroundColor: context.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Payment method',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: context.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Credit Card Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.surface,
                  borderRadius: BorderRadius.circular(20),
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
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Credit Card',
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: context.primary,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_up, color: context.onSurface),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Payment Method Icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPaymentIcon(
                          context,
                          'assets/images/visa_icon.png',
                        ),
                        _buildPaymentIcon(
                          context,
                          'assets/images/mastercard_icon.png',
                        ),
                        _buildPaymentIcon(
                          context,
                          'assets/images/pay_icon.png',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Credit Card UI (Image)
                    SizedBox(
                      width: double.infinity,
                      child: SvgPicture.asset(
                        'assets/images/mockvisa.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Google Pay
              _buildListItem(context, 'Google Pay'),
              const SizedBox(height: 16),
              // Mobile Banking
              _buildListItem(context, 'Mobile Banking'),
              const SizedBox(height: 24),
              // Receipt Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Send receipt to your email',
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppExtraColors.paleSky,
                    ),
                  ),
                  Switch.adaptive(
                    value: false,
                    onChanged: (v) {},
                    activeColor: AppExtraColors.blueAccent,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Buy Button
              CustomButton(
                text: 'Buy',
                onPressed: () {},
                width: double.infinity,
                backgroundColor: AppExtraColors.navyBlue,
                height: 56,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentIcon(BuildContext context, String assetName) {
    return SizedBox(
      width: 90,
      height: 40,
      child: Image.asset(assetName, fit: BoxFit.contain),
    );
  }

  Widget _buildListItem(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppExtraColors.navyBlue,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppExtraColors.navyBlue,
          ),
        ],
      ),
    );
  }
}
