import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:team_7/core/di/dependency_injection.dart';
import 'package:team_7/firebase_options.dart';
import 'package:team_7/team_7.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupGetIt();
  runApp(const Team7());
}
