import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/app/common/extensions/build_context_extensions.dart';
import 'package:todo/app/common/providers/secure_storage_provider.dart';
import 'package:todo/app/features/auth/presentation/screens/login_screen.dart';
import 'package:todo/app/features/home/presentation/providers/home_providers.dart';
import 'package:todo/app/features/home/presentation/widgets/toggle_button_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  static const String route = '/';
  static const String name = 'home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  bool? darkMode;
  
  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    darkMode = ref.watch(darkModeProvider);

    return Scaffold(
      appBar: AppBar(
        leading: platform == TargetPlatform.android
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
        actions: [
          // Dots menu button
          if (platform == TargetPlatform.android)
            PopupMenuButton<String>(
              onSelected: (value) {
                _handleMenuSelection(context, value);
              },
              icon: const Icon(Icons.more_vert), // Dots for Android
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 'option1',
                  child: Text('Option 1'),
                ),
                const PopupMenuItem(
                  value: 'option2',
                  child: Text('Option 2'),
                ),
              ],
            )
          else
            IconButton(
              icon: const Icon(CupertinoIcons.ellipsis), // Dots for iOS
              onPressed: () {
                _showCupertinoDialog(context);
              },
            ),
        ],
      ),
      body: Column(

      ),
    );
  }

  // Handle menu selection for Material
  void _handleMenuSelection(BuildContext context, String value) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Selected: $value'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Show Cupertino dialog
  void _showCupertinoDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Row(
          children: [
            Expanded(child: Text('App Theme', style: context.textTheme.titleMedium,)),
            CustomToggleButton(
                darkMode: darkMode!,
                onChanged: (val){
                  darkMode = ref.read(darkModeProvider.notifier).state = val;
                  Navigator.pop(context);
            }),
          ],
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _handleMenuSelection(context, 'Profile Information');
            },
            child: const Text('Profile Information'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              ref.read(secureStorageProvider.notifier).deleteToken();
              context.goNamed(LoginScreen.name);
            },
            child: Text('Logout', style: context.textTheme.titleMedium!.copyWith(color: Colors.red) ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}
