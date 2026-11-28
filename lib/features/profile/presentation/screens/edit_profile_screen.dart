import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/custom_bottom_nav.dart'; // <-- Tu archivo existente

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();
  final _rfcCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _contactCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.orangePrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 35,
                    errorBuilder: (_, __, ___) => const Icon(Icons.storefront, color: AppColors.orangePrimary),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // Avatar con botón de editar
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0xFFB2DFDB),
                            child: Icon(Icons.person, size: 65, color: AppColors.blueNavy),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.orangePrimary, width: 1.5),
                          ),
                          child: const Icon(Icons.edit_outlined, size: 18, color: AppColors.orangePrimary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    _buildUnderlineField(_emailCtrl, 'Correo electrónico', Icons.email_outlined),
                    _buildUnderlineField(_passCtrl, 'Contraseña', Icons.lock_outline, isPassword: true),
                    _buildUnderlineField(_companyCtrl, 'Nombre del negocio o empresa', Icons.business_outlined),
                    _buildUnderlineField(_rfcCtrl, 'RFC', Icons.menu_book_outlined),
                    _buildUnderlineField(_phoneCtrl, 'Numero de teléfono', Icons.phone_outlined),
                    _buildUnderlineField(_contactCtrl, 'Nombre del contacto', Icons.person_outline),
                    _buildUnderlineField(_addressCtrl, 'Dirección comercial', Icons.location_on_outlined),

                    const SizedBox(height: 28),
                    SizedBox(
                      width: 180,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orangePrimary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Guardar'),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Usamos tu widget CustomBottomNav
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3,
        onTap: (_) {},
      ),
    );
  }

  Widget _buildUnderlineField(TextEditingController ctrl, String label, IconData icon, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.purpleDark, fontSize: 12),
          suffixIcon: Icon(icon, color: AppColors.purpleDark, size: 20),
          filled: false,
          border: const UnderlineInputBorder(),
          enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.orangePrimary)),
          focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.purpleDark, width: 1.5)),
        ),
      ),
    );
  }
}