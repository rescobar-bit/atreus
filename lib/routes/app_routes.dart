import 'package:atreus/screens/auth/login_screen.dart';
import 'package:atreus/screens/auth/microsoft_login_screen.dart';
import 'package:atreus/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static RouterConfig<Object>? getRoutes(GlobalKey<NavigatorState> navigatorKey){
    List<RouteBase> routes = [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
        routes: [
          GoRoute(
            path: MicrosoftLoginScreen.routeName,
            name: MicrosoftLoginScreen.routeName,
            builder: (context, state) => const MicrosoftLoginScreen(),
          ),
          GoRoute(
            path: HomeScreen.routeName,
            name: HomeScreen.routeName,
            builder: (context, state) => const HomeScreen(),
          )
        ]
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