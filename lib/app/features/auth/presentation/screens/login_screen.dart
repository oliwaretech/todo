import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/app/common/extensions/build_context_extensions.dart';
import 'package:todo/app/common/helpers/constans.dart';
import 'package:todo/app/common/helpers/input_validators.dart';
import 'package:todo/app/common/helpers/notifications/app_notifications.dart';
import 'package:todo/app/common/providers/connectivity_provider.dart';
import 'package:todo/app/core/themes/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/app/features/auth/presentation/screens/register_screen.dart';
import 'package:todo/app/features/auth/providers/auth_provider.dart';
import 'package:todo/app/features/home/presentation/screens/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static const String route = '/login';
  static const String name = 'login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool obscurePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final connectivityResult = ref.watch(connectivityProvider);
    final hasConnection = connectivityResult != null && !connectivityResult.contains(ConnectivityResult.none);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.login_rounded, size: 100, color: AppColors.primary),
              const SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.email,
                ),
                validator: InputValidators.email,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.password,
                  suffixIcon: GestureDetector(
                    child: obscurePassword
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onTap: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),
                validator: InputValidators.notEmpty,
                obscureText: obscurePassword,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if(!hasConnection) {
                      AppNotifications.showError(message: 'No internet connection');
                      return;
                    }
                    if(emailController.text.isEmpty || passwordController.text.isEmpty) {
                      AppNotifications.showError(message: 'Please fill all fields');
                      return;
                    }
                    login();

                  },
                  child: Text(AppLocalizations.of(context)!.login),
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: context.textTheme.bodySmall,
                  children: [
                    TextSpan(text: '${AppLocalizations.of(context)!.new_in_the_app} '),
                    TextSpan(
                      text: AppLocalizations.of(context)!.create_account,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.goNamed(RegisterScreen.name);
                        },
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    final close = AppNotifications.showLoading();
    try {
      await ref.read(authProvider).signIn(
        emailController.text,
        passwordController.text,
      );
      context.goNamed(HomeScreen.name);
    } catch (e) {
      String message = mounted ? AppLocalizations.of(context)!.default_error : defaultErrorText;
      if (e is Exception) {
        message = e.toString();
      }
      AppNotifications.showError(message: message);
    } finally {
      close();
    }
  }
}
