import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navegar a la pantalla de bienvenida después de 2.5 segundos
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logotipo principal de DIXEMA
            // Logotipo principal de DIXEMA en imagen
            Image.asset(
              'assets/images/logo_dixema.png',
              height: 200, // Ajusta la altura según se vea mejor tu logo
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 15),
            Text(
              'DIXEMA',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.blueNavy,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}