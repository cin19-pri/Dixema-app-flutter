import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import './login_screen.dart';
import './register_screen.dart';

class Welcome1Screen extends StatelessWidget {
  const Welcome1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 26.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'DIXEMA',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: AppColors.purpleDark,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textDark),
                        children: [
                          TextSpan(text: 'El '),
                          TextSpan(text: 'puente ', style: TextStyle(color: AppColors.orangePrimary)),
                          TextSpan(text: 'que tu\nnegocio '),
                          TextSpan(text: 'requiere', style: TextStyle(color: AppColors.orangePrimary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Ilustración central
                    Expanded(
                      child: Image.asset(
                        'assets/images/welcome-img.png', // Asegúrate de agregar la imagen o un placeholder
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.devices_outlined,
                          size: 140,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tarjeta inferior curvada
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28.0),
              decoration: const BoxDecoration(
                color: AppColors.purpleDark,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '¡Bienvenido!',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Al crear una cuenta o iniciar sesión, aceptas nuestros términos y condiciones. Descubre como utilizamos tus datos en nuestra Política de privacidad y Política de cookies.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                  ),
                  const SizedBox(height: 24),
                  
                  // Botón Crea una Cuenta
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orangePrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterScreen()),
                      );
                    },
                    child: const Text('Crea una Cuenta'),
                  ),
                  const SizedBox(height: 14),

                  // Botón Iniciar Sesión
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orangePrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text('Iniciar Sesion'),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}