import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  void popUntil(String route) {
    final router = GoRouter.of(this);
    while (router
        .routerDelegate.currentConfiguration.matches.last.matchedLocation !=
        route) {
      if (!canPop()) {
        return;
      }
      pop();
    }
  }
}
