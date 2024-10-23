import 'package:atreus/screens/auth/login_method_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static RouterConfig<Object>? getRoutes(GlobalKey<NavigatorState> navigatorKey){
    List<RouteBase> routes = [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginMethodScreen(),
      )
    ];

    return GoRouter(
      routes: routes,
      navigatorKey: navigatorKey,
      redirect: (context, state) {
        return null;
      },
    );
  }
}