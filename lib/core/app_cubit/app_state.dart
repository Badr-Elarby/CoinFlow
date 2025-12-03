import 'package:flutter/material.dart';

sealed class AppState {
  final ThemeMode themeMode;
  final bool hasInternet;

  AppState({this.themeMode = ThemeMode.system, this.hasInternet = true});
}

final class AppInitial extends AppState {
  AppInitial({super.themeMode, super.hasInternet});
}

final class AppUpdated extends AppState {
  AppUpdated({required super.themeMode, required super.hasInternet});
}
