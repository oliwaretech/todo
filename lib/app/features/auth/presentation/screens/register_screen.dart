import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/app/common/helpers/constans.dart';
import 'package:todo/app/common/helpers/input_validators.dart';
import 'package:todo/app/common/helpers/notifications/app_notifications.dart';
import 'package:todo/app/common/providers/connectivity_provider.dart';
import 'package:todo/app/core/themes/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/app/features/auth/presentation/screens/login_screen.dart';
import 'package:todo/app/features/auth/providers/auth_provider.dart';
import 'package:todo/app/features/home/presentation/screens/home_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  static const String route = '/register';
  static const String name = 'register';

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  bool obscurePassword = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final connectivityResult = ref.watch(connectivityProvider);
    final hasConnection = connectivityResult != null && !connectivityResult.contains(ConnectivityResult.none);

    return Scaffold(
      appBar: AppBar(
        leading: Platform.isAndroid
            ? IconButton(
          icon: const Icon(Icons.arrow_back), // Material back arrow
          onPressed: () {
            context.goNamed(LoginScreen.name);
          },
        )
            : GestureDetector(
          onTap: () {
            context.goNamed(LoginScreen.name);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(
              CupertinoIcons.back, // Cupertino back arrow
              size: 28,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.app_registration_rounded, size: 100, color: AppColors.primary),
              const SizedBox(height: 40),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.name,
                ),
                validator: InputValidators.email,
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 16),
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
                    if(emailController.text.isEmpty || passwordController.text.isEmpty || nameController.text.isEmpty) {
                      AppNotifications.showError(message: 'Please fill all fields');
                      return;
                    }
                    register();
                  },
                  child: Text(AppLocalizations.of(context)!.create_account),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    final close = AppNotifications.showLoading();
    try {
      await ref.read(authProvider).register(
        emailController.text,
        passwordController.text,
      );
      await ref.read(authProvider).registerUser(
        nameController.text,
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
