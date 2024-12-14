
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/app/features/auth/presentation/screens/login_screen.dart';
import 'package:todo/app/features/auth/presentation/screens/register_screen.dart';
import 'package:todo/app/features/presentation/screens/home_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootKey');

  final router = GoRouter(
    initialLocation: HomeScreen.route,
    debugLogDiagnostics: kDebugMode,
    observers: [
      BotToastNavigatorObserver(),
    ],
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: HomeScreen.route,
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: LoginScreen.route,
        name: LoginScreen.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RegisterScreen.route,
        name: RegisterScreen.name,
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
  return router;
});