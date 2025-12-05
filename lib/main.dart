import 'package:flutter/material.dart';
import 'package:team_7/core/di/dependency_injection.dart';
import 'package:team_7/team7_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  runApp(const Team7App());
}
