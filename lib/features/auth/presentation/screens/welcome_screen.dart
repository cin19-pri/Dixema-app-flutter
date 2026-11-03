import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'welcome_1_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? selectedRole; // 'provider' o 'buyer'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                  children: const [
                    TextSpan(text: 'Bienvenidos a '),
                    TextSpan(
                      text: 'DIXEMA',
                      style: TextStyle(color: AppColors.orangePrimary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '¡Por favor elige la opción con la que quieres unirte a nuestra familia!',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),
              const SizedBox(height: 30),
              
              // Opción 1: Proveedor
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedRole = 'provider'),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: selectedRole == 'provider'
                          ? AppColors.orangePrimary
                          : AppColors.surfaceWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selectedRole == 'provider'
                            ? AppColors.orangePrimary
                            : AppColors.inputBorder,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.storefront_rounded,
                          size: 60,
                          color: selectedRole == 'provider'
                              ? Colors.white
                              : AppColors.orangePrimary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Proveedor',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: selectedRole == 'provider'
                                ? Colors.white
                                : AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '"Ofrezco productos y busco nuevos clientes (Venta al mayoreo)."',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: selectedRole == 'provider'
                                ? Colors.white70
                                : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Opción 2: Comprador
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedRole = 'buyer'),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: selectedRole == 'buyer'
                          ? AppColors.purpleDark
                          : AppColors.surfaceWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: selectedRole == 'buyer'
                            ? AppColors.purpleDark
                            : AppColors.inputBorder,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_rounded,
                          size: 60,
                          color: selectedRole == 'buyer'
                              ? Colors.white
                              : AppColors.purpleDark,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Comprador',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: selectedRole == 'buyer'
                                ? Colors.white
                                : AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '"Busco proveedores y proyectos al mayoreo (Compra grande)."',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: selectedRole == 'buyer'
                                ? Colors.white70
                                : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

             // Botón de Continuar
            ElevatedButton(
              onPressed: selectedRole == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Welcome1Screen(),
                        ),
                      );
                    },
              child: const Text('Continuar'),
            ),
            ],
          ),
        ),
      ),
    );
  }
}