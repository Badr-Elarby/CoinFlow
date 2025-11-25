import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:team_7/core/app_cubit/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_7/core/helpers/shared_pref_helper.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial()) {
    _loadTheme();
    checkConnection();
  }

  StreamSubscription? _subscription;

  Future<void> _loadTheme() async {
    final saved = await SharedPrefHelper.getString('theme');

    final themeMode = switch (saved) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    emit(AppInitial(themeMode: themeMode, hasInternet: state.hasInternet));
  }

  Future<void> toggleTheme() async {
    final currentTheme = state.themeMode;
    final newMode = currentTheme == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    emit(AppUpdated(themeMode: newMode, hasInternet: state.hasInternet));

    await SharedPrefHelper.setData('theme', newMode.name);
  }

  void checkConnection() {
    _subscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      final hasInternet = result.any(
        (e) => e == ConnectivityResult.wifi || e == ConnectivityResult.mobile,
      );

      emit(AppUpdated(themeMode: state.themeMode, hasInternet: hasInternet));
    });
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
    return super.close();
  }
}
