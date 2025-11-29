import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_7/core/app_cubit/app_cubit.dart';
import 'package:team_7/core/app_cubit/app_state.dart';
import 'package:team_7/core/routing/app_routes.dart';
import 'package:team_7/core/theming/app_theme.dart';

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: providers,
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final cubit = context.read<AppCubit>();
              return MaterialApp.router(
                title: 'Graduation Project',
                routerConfig: routes,
                debugShowCheckedModeBanner: false,
                themeMode: cubit.themeMode,
                darkTheme: AppTheme.darkTheme,
                theme: AppTheme.lightTheme,
              
              );
            },
          ),
        );
      },
    );
  }

  final providers = [
    BlocProvider<AppCubit>(create: (context) => AppCubit()),
  ];
}