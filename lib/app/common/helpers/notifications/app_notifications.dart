
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/common/widgets/toast_widget.dart';

class AppNotifications {
  static void Function() showLoading() {
    return BotToast.showLoading(
      backButtonBehavior: BackButtonBehavior.ignore,
    );
  }

  static void showError({
    String message = '',
    String? label,
    Widget? customAction,
  }) {
    BotToast.showCustomNotification(
      toastBuilder: (c) => Toast.error(
        text: message,
        cancel: c,
        label: label,
        customAction: customAction,
      ),
      align: Alignment.bottomCenter,
      useSafeArea: true,
      duration: const Duration(seconds: 3),
    );
  }

  static void showSuccess({
    String message = '',
    String? label,
    Widget? customAction,
  }) {
    BotToast.showCustomNotification(
      toastBuilder: (c) => Toast.success(
        text: message,
        cancel: c,
        label: label,
        customAction: customAction,
      ),
      align: Alignment.bottomCenter,
      useSafeArea: true,
      duration: const Duration(seconds: 3),
    );
  }

  static void showWarning({
    String message = '',
    String? label,
    Widget? customAction,
  }) {
    BotToast.showCustomNotification(
      toastBuilder: (c) => Toast.warning(
        text: message,
        cancel: c,
        label: label,
        customAction: customAction,
      ),
      align: Alignment.bottomCenter,
      useSafeArea: true,
      duration: const Duration(seconds: 3),
    );
  }
}
