import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/custom_bottom_nav.dart';
import '../../../auth/presentation/screens/forgot_password_screen.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../../chat/presentation/screens/chat_screen.dart';
import '../../../products/presentation/screens/dashboard_screen.dart';
import '../../../products/presentation/screens/gestion_screen.dart';
import 'edit_profile_screen.dart';
import 'privacy_policy_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header superior con flecha y logo
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.orangePrimary),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const GestionScreen(),
                            transitionDuration: Duration.zero,
                          ),
                        );
                      }
                    },
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 35,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.storefront,
                      color: AppColors.orangePrimary,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // Avatar circular
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xFFB2DFDB),
                        child: Icon(Icons.person, size: 70, color: AppColors.blueNavy),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Nombre de la empresa',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.purpleDark,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sección Cuenta
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Cuenta',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            _buildMenuOption(
                              icon: Icons.person_outline,
                              title: 'Información general',
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                              ),
                            ),
                            const Divider(height: 1, indent: 20, endIndent: 20),
                            _buildMenuOption(
                              icon: Icons.lock_outline,
                              title: 'Cambiar contraseña',
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sección Configuración
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Configuración',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            _buildMenuOption(
                              icon: Icons.privacy_tip_outlined,
                              title: 'Política de privacidad',
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                              ),
                            ),
                            const Divider(height: 1, indent: 20, endIndent: 20),
                            _buildMenuOption(
                              icon: Icons.language_outlined,
                              title: 'Idioma',
                              onTap: () {},
                            ),
                            const Divider(height: 1, indent: 20, endIndent: 20),
                            _buildMenuOption(
                              icon: Icons.support_agent_outlined,
                              title: 'Ayuda & Soporte',
                              onTap: () {},
                            ),
                            const Divider(height: 1, indent: 20, endIndent: 20),
                            _buildMenuOption(
                              icon: Icons.logout_rounded,
                              title: 'Cerrar sesión',
                              onTap: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => const LoginScreen()),
                                (route) => false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3, // Perfil seleccionado
        onTap: (index) {
          if (index == 3) return;

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const DashboardScreen(),
                transitionDuration: Duration.zero,
              ),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const GestionScreen(),
                transitionDuration: Duration.zero,
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      leading: Icon(icon, color: AppColors.purpleDark, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_rounded, color: AppColors.purpleDark, size: 18),
      onTap: onTap,
    );
  }
}