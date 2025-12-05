import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/app_cubit/app_cubit.dart';
import 'package:team_7/core/app_cubit/app_state.dart';
import 'package:team_7/core/di/dependency_injection.dart';
import 'package:team_7/core/theming/app_theme.dart';

class Team7App extends StatelessWidget {
  const Team7App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppCubit>(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
          );
        },
      ),
    );
  }
}
