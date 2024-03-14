import 'package:flutter/material.dart';
import 'package:tasks_app/app/app.dart';
import 'package:tasks_app/dependency_injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const App());
}
