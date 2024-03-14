import 'package:flutter/material.dart';
import 'package:simple_login/config/app_theme.dart';
import 'package:simple_login/features/login/pages/login_page.dart';

class SimpleLoginApp extends StatelessWidget {
  const SimpleLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.ligth,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
