import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'login_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Estados de validación de contraseña
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  void _validatePassword(String value) {
    setState(() {
      _hasMinLength = value.length > 6;
      _hasUppercase = value.contains(RegExp(r'[A-Z]'));
      _hasLowercase = value.contains(RegExp(r'[a-z]'));
      _hasNumber = value.contains(RegExp(r'[1-9]'));
      _hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header con flecha y badge "Contraseña Nueva"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.orangePrimary,
                      size: 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: const BoxDecoration(
                      color: AppColors.orangePrimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Contraseña Nueva',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Título principal
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.purpleDark,
                            height: 1.3,
                          ),
                          children: [
                            TextSpan(
                              text: 'Ingresa tu ',
                              style: TextStyle(color: AppColors.orangePrimary),
                            ),
                            TextSpan(text: 'nueva\n'),
                            TextSpan(
                              text: 'contraseña',
                              style: TextStyle(color: AppColors.orangePrimary),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Sección "Recuerda" con lista de requisitos
                    const Text(
                      'Recuerda',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.purpleDark,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),

                    _buildRequirementItem('1. mas de 6 caracteres', _hasMinLength),
                    _buildRequirementItem('2. Una letra mayuscula', _hasUppercase),
                    _buildRequirementItem('3. Una letra miniscula', _hasLowercase),
                    _buildRequirementItem('4. Un numero del 1-9', _hasNumber),
                    _buildRequirementItem('5. Un simbolo especial', _hasSpecialChar),
                    const SizedBox(height: 25),

                    // Input 1: Nueva contraseña
                    const Text(
                      'Nueva contraseña',
                      style: TextStyle(color: AppColors.purpleDark, fontSize: 11),
                    ),
                    const SizedBox(height: 6),
                    _buildPasswordField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      onChanged: _validatePassword,
                      onToggleVisibility: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Input 2: Confirma tu contraseña
                    const Text(
                      'Confirma tu contraseña',
                      style: TextStyle(color: AppColors.purpleDark, fontSize: 11),
                    ),
                    const SizedBox(height: 6),
                    _buildPasswordField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      onToggleVisibility: () {
                        setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Switch "Recordarme"
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: _rememberMe,
                            activeColor: Colors.white,
                            activeTrackColor: AppColors.orangePrimary,
                            inactiveThumbColor: AppColors.orangePrimary,
                            inactiveTrackColor: Colors.white,
                            trackOutlineColor: WidgetStateProperty.all(AppColors.orangePrimary),
                            onChanged: (val) => setState(() => _rememberMe = val),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Recordarme',
                          style: TextStyle(
                            color: AppColors.orangePrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),

                    // Botón Guardar (Azul Marino Oscuro)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueNavy,
                          foregroundColor: Colors.white,
                          elevation: 3,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          // Al guardar redirige de nuevo a Login
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Guardar',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementItem(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(
            Icons.check_box_outlined,
            size: 18,
            color: isValid ? Colors.green : AppColors.orangePrimary,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isValid ? Colors.green : AppColors.purpleDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    ValueChanged<String>? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.orangePrimary.withOpacity(0.6),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14, color: AppColors.textDark),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.lock_outline_rounded,
            color: AppColors.purpleDark,
            size: 22,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}