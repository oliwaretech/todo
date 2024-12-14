import 'package:flutter/material.dart';
import 'package:todo/app/app.dart';
import 'package:todo/bootstrap.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap(() => const App());

}

