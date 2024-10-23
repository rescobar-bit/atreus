import 'package:atreus/screens/auth/credentials_login_screen.dart';
import 'package:atreus/screens/auth/login_method_screen.dart';
import 'package:atreus/screens/auth/microsoft_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static RouterConfig<Object>? getRoutes(GlobalKey<NavigatorState> navigatorKey){
    List<RouteBase> routes = [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginMethodScreen(),
        routes: [
          GoRoute(
            path: CredentialsLoginScreen.routeName,
            name: CredentialsLoginScreen.routeName,
            builder: (context, state) => const CredentialsLoginScreen(),
          ),
          GoRoute(
            path: MicrosoftLoginScreen.routeName,
            name: MicrosoftLoginScreen.routeName,
            builder: (context, state) => const MicrosoftLoginScreen(),
          )
        ]
      )
    ];

    return GoRouter(
      routes: routes,
      navigatorKey: navigatorKey,
      redirect: (context, state) {
        return "/${CredentialsLoginScreen.routeName}";
      },
    );
  }
}