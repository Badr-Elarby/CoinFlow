import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_7/core/routing/routes.dart';
import 'package:team_7/features/main_layout/presentation/page/mainlayout_screen.dart';

import 'route_observer.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

final CustomGoRouterObserver customGoRouterObserver = CustomGoRouterObserver();

final routes = GoRouter(
  initialLocation: Routes.mainLayout,
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
  observers: [],
  routes: [
    GoRoute(
      path: Routes.mainLayout,
      builder: (context, state) => const MainLayout(),
    ),
  ],
);
