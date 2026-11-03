import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _rfcController = TextEditingController();
  final _phoneController = TextEditingController();
  final _contactPhoneController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              // Logo
              Image.asset(
                'assets/images/logo_dixema.png',
                height: 85,
                errorBuilder: (_, __, ___) => const Icon(Icons.storefront, color: AppColors.orangePrimary, size: 45),
              ),
              const SizedBox(height: 16),
              
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.purpleDark),
                  children: [
                    TextSpan(text: 'Crear una '),
                    TextSpan(text: 'nueva ', style: TextStyle(color: AppColors.orangePrimary)),
                    TextSpan(text: 'cuenta'),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Recuerda colocar os datos correctos',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.purpleDark, fontSize: 12),
              ),
              const SizedBox(height: 25),

              // Inputs Underline
              _buildUnderlineInput(_emailController, 'Correo electrónico', Icons.email_outlined),
              _buildUnderlineInput(_passwordController, 'Contraseña', Icons.lock_outline, isPassword: true),
              _buildUnderlineInput(_businessNameController, 'Nombre de negocio o empresa', Icons.business_outlined),
              _buildUnderlineInput(_rfcController, 'RFC', Icons.menu_book_outlined),
              _buildUnderlineInput(_phoneController, 'Numero de telefono', Icons.phone_outlined, keyboardType: TextInputType.phone),
              _buildUnderlineInput(_contactPhoneController, 'Numero de contacto', Icons.person_outline, keyboardType: TextInputType.phone),
              _buildUnderlineInput(_addressController, 'Direccion comercial', Icons.location_on_outlined),
              
              const SizedBox(height: 30),

              // Botón Crear cuenta
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orangePrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {},
                child: const Text('Crear cuenta'),
              ),
              const SizedBox(height: 20),

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
              const SizedBox(height: 12),

              // Icono Google
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
              const SizedBox(height: 20),

              // Link a Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ya tienes una cuenta? ', style: TextStyle(fontSize: 12, color: AppColors.purpleDark)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'INICIA',
                      style: TextStyle(color: AppColors.purpleDark, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnderlineInput(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.purpleDark, fontSize: 12),
          suffixIcon: Icon(icon, color: AppColors.purpleDark, size: 20),
          border: const UnderlineInputBorder(),
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.inputBorder)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.purpleDark)),
          filled: false,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }
}