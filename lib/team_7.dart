import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/app_cubit/app_cubit.dart';
import 'package:team_7/core/app_cubit/app_state.dart';
import 'package:team_7/core/routing/app_router.dart';
import 'package:team_7/core/theming/app_theme.dart';

class Team7 extends StatelessWidget {
  const Team7({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Team 7',
            themeMode: state.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
