import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/screens/splash_screen.dart';

void main() {
  runApp(const DixemaApp());
}

class DixemaApp extends StatelessWidget {
  const DixemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIXEMA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}