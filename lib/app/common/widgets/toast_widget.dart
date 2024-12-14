import 'package:flutter/material.dart';
import 'package:todo/app/common/extensions/build_context_extensions.dart';
import 'package:todo/app/core/themes/app_colors.dart';

class Toast extends StatelessWidget {
  const Toast({
    required this.label,
    required this.text,
    required this.cancel,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    this.customAction,
    super.key,
  });

  factory Toast.error({
    required String text,
    required void Function() cancel,
    String? label,
    Widget? customAction,
  }) {
    return Toast(
      label: label ?? 'Error',
      text: text,
      cancel: cancel,
      backgroundColor: AppColors.errorBackground,
      foregroundColor: AppColors.error,
      icon: Icons.error_outline,
      customAction: customAction,
    );
  }

  factory Toast.warning({
    required String text,
    required void Function() cancel,
    String? label,
    Widget? customAction,
  }) {
    return Toast(
      label: label ?? 'Warning',
      text: text,
      cancel: cancel,
      backgroundColor: AppColors.warningBackground,
      foregroundColor: AppColors.warning,
      icon: Icons.warning_amber_outlined,
      customAction: customAction,
    );
  }

  factory Toast.success({
    required String text,
    required void Function() cancel,
    String? label,
    Widget? customAction,
  }) {
    return Toast(
      label: label ?? 'Success',
      text: text,
      cancel: cancel,
      backgroundColor: AppColors.successBackground,
      foregroundColor: AppColors.success,
      icon: Icons.check_circle_outline,
      customAction: customAction,
    );
  }

  final String text;
  final String label;
  final void Function() cancel;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final Widget? customAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 80),
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: foregroundColor.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: foregroundColor.withOpacity(0.16),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: foregroundColor,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: label,
                style: context.textTheme.labelMedium?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  const TextSpan(text: '\n'),
                  TextSpan(
                    text: text,
                    style: context.textTheme.bodySmall
                        ?.copyWith(color: AppColors.neutral400, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          customAction ??
              Center(
                heightFactor: 2,
                child: GestureDetector(
                  onTap: cancel,
                  child: const Icon(
                    Icons.close,
                    color: AppColors.neutral600,
                    size: 18,
                  ),
                ),
              ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
