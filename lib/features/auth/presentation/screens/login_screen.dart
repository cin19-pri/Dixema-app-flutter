import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header curvado superior
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 50, left: 24, right: 24, bottom: 30),
              decoration: const BoxDecoration(
                color: AppColors.purpleDark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo_dixema.png',
                    height: 200,
                    errorBuilder: (_, __, ___) => const Icon(Icons.storefront, color: Colors.white, size: 45),
                  ),
                  const SizedBox(height: 15),
                  
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                      children: [
                        TextSpan(text: 'Bienvenido '),
                        TextSpan(text: 'de ', style: TextStyle(color: AppColors.orangePrimary)),
                        TextSpan(text: 'nuevo!'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Llena los espacios con tu información para poder ingresar a la app',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            
            // Formulario
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Correo electrónico
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      labelStyle: TextStyle(color: AppColors.purpleDark, fontSize: 13),
                      suffixIcon: Icon(Icons.email_outlined, color: AppColors.purpleDark),
                      border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.inputBorder)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.purpleDark)),
                      filled: false,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Contraseña
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: const TextStyle(color: AppColors.purpleDark, fontSize: 13),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: AppColors.purpleDark,
                        ),
                        onPressed: (
                          
                        ) => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      border: const UnderlineInputBorder(),
                      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.inputBorder)),
                      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.purpleDark)),
                      filled: false,
                    ),
                  ),
                  
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Olvide mi contraseña',
                        style: TextStyle(color: AppColors.orangePrimary, fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botón Iniciar Sesión
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orangePrimary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () {},
                    child: const Text('Iniciar sesión'),
                  ),
                  const SizedBox(height: 25),

                  // Divisor Google
                  Row(
                    children: const [
                      Expanded(child: Divider(color: AppColors.orangePrimary, thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('o iniciar con', style: TextStyle(color: AppColors.orangePrimary, fontSize: 12)),
                      ),
                      Expanded(child: Divider(color: AppColors.orangePrimary, thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Botón de Google
                  Center(
                    child: InkWell(
                      onTap: () {
                        // Acción de inicio de sesión con Google
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/images/google_logo.png',
                          height: 28,
                          width: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Link a Registro
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Aun no tienes una cuenta? ', style: TextStyle(fontSize: 12, color: AppColors.purpleDark)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const RegisterScreen()),
                          );
                        },
                        child: const Text(
                          'RESGISTRATE',
                          style: TextStyle(color: AppColors.purpleDark, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}