import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/app_cubit/app_cubit.dart';
import 'package:team_7/core/app_cubit/app_state.dart';
import 'package:team_7/core/responsive/size_extensions.dart';
import 'package:team_7/core/responsive/app_spacing.dart';
import 'package:team_7/core/theming/theme_extensions.dart';
import 'package:team_7/core/theming/app_text.dart';
import 'package:team_7/core/di/injection_container.dart';
import 'package:team_7/features/settings/presentation/widgets/user_profile_header.dart';
import 'package:team_7/features/settings/presentation/widgets/settings_section_title.dart';
import 'package:team_7/features/settings/presentation/widgets/settings_item_tile.dart';
import 'package:team_7/features/settings/presentation/widgets/settings_switch_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = getIt<FirebaseAuth>();
    final currentUser = firebaseAuth.currentUser;
    final userName = currentUser?.displayName ?? 'Badr Elarby';

    return Scaffold(
      backgroundColor: context.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSpacing.h24,

                // Title
                Text(
                  'Settings',
                  style: AppText.white28Bold.copyWith(color: context.onSurface),
                ),
                AppSpacing.h24,

                // User Profile Header
                UserProfileHeader(userName: userName),
                AppSpacing.h24,

                // General Section
                const SettingsSectionTitle(title: 'General'),
                AppSpacing.h16,
                const SettingsItemTile(
                  icon: Icons.person_outline,
                  title: 'My Account',
                ),
                const SettingsItemTile(
                  icon: Icons.payment_outlined,
                  title: 'Billing/Payment',
                ),
                const SettingsItemTile(
                  icon: Icons.help_outline,
                  title: 'FAQ & Support',
                ),
                AppSpacing.h24,

                // Settings Section
                const SettingsSectionTitle(title: 'Settings'),
                AppSpacing.h16,
                const SettingsItemTile(
                  icon: Icons.language_outlined,
                  title: 'Language',
                ),

                // Dark Mode Toggle
                BlocBuilder<AppCubit, AppState>(
                  builder: (context, state) {
                    final isDarkMode = state.themeMode == ThemeMode.dark;

                    return SettingsSwitchTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark Mode',
                      value: isDarkMode,
                      onChanged: (value) {
                        context.read<AppCubit>().toggleTheme();
                      },
                    );
                  },
                ),
                AppSpacing.h24,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
