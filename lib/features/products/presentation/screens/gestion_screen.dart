import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/custom_bottom_nav.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../../chat/presentation/screens/chat_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import 'add_product_screen.dart';
import 'dashboard_screen.dart';
import 'product_repository.dart';

class GestionScreen extends StatefulWidget {
  const GestionScreen({super.key});

  @override
  State<GestionScreen> createState() => _GestionScreenState();
}

class _GestionScreenState extends State<GestionScreen> {
  final int _selectedNavIndex = 1; // "Gestion" activo por defecto
  String _selectedFilter = 'Todos';

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
          contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: AppColors.orangePrimary, width: 1.5),
          ),
          title: Row(
            children: const [
              Icon(Icons.logout_rounded, color: AppColors.orangePrimary, size: 26),
              SizedBox(width: 10),
              Text(
                'Cerrar sesión',
                style: TextStyle(
                  color: AppColors.purpleDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: const Text(
            '¿Estás seguro de que deseas cerrar tu sesión en Dixema?',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.purpleDark,
                        side: const BorderSide(color: AppColors.purpleDark, width: 1.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orangePrimary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 44),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Aceptar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Advertencia para confirmar eliminación de producto
  void _showDeleteProductDialog(int index, String productName) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
          contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: AppColors.orangePrimary, width: 1.5),
          ),
          title: Row(
            children: const [
              Icon(Icons.delete_outline_rounded, color: AppColors.orangePrimary, size: 26),
              SizedBox(width: 10),
              Text(
                'Eliminar producto',
                style: TextStyle(
                  color: AppColors.purpleDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Text(
            '¿Estás seguro de que deseas eliminar "$productName"?',
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.purpleDark,
                        side: const BorderSide(color: AppColors.purpleDark, width: 1.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orangePrimary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 44),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        setState(() {
                          ProductRepository.removeProductAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Producto "$productName" eliminado'),
                            backgroundColor: const Color(0xFF34385A),
                          ),
                        );
                      },
                      child: const Text(
                        'Eliminar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _openAddProduct() async {
    final newProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddProductScreen(),
      ),
    );

    if (newProduct != null && newProduct is Map) {
      setState(() {
        ProductRepository.addProduct(newProduct);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Producto añadido exitosamente'),
            backgroundColor: AppColors.orangePrimary,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ProductRepository.products;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedNavIndex,
        onTap: (index) {
          if (index == _selectedNavIndex) return;

          if (index == 0) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const DashboardScreen(),
                transitionDuration: Duration.zero,
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatScreen()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const ProfileScreen(),
                transitionDuration: Duration.zero,
              ),
            );
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: AppColors.orangePrimary,
                      size: 32,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    tooltip: 'Cerrar sesión',
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: AppColors.orangePrimary,
                      size: 28,
                    ),
                    onPressed: _showLogoutDialog,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Center(
                child: Column(
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.purpleDark,
                        ),
                        children: [
                          TextSpan(text: 'Bienvenido '),
                          TextSpan(
                            text: 'cosmica!',
                            style: TextStyle(color: AppColors.orangePrimary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Que desea hacer hoy',
                      style: TextStyle(
                        color: AppColors.purpleDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF70739E),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gestion del producto',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orangePrimary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(130, 34),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 2,
                          ),
                          onPressed: _openAddProduct,
                          child: const Text(
                            'Añadir producto',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.purpleDark,
                            minimumSize: const Size(110, 34),
                            side: const BorderSide(color: AppColors.orangePrimary, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            setState(() => _selectedFilter = 'Todos');
                          },
                          child: Text(
                            _selectedFilter,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.orangePrimary.withOpacity(0.7),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gestion del producto',
                      style: TextStyle(
                        color: AppColors.purpleDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 14),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        final name = product['name'] as String;
                        return _buildProductCard(
                          name: name,
                          price: product['price'] as String,
                          isAvailable: product['available'] as bool,
                          imagePath: product['image'] as String,
                          imageBytes: product['imageBytes'] as Uint8List?,
                          onDelete: () => _showDeleteProductDialog(index, name),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard({
    required String name,
    required String price,
    required bool isAvailable,
    required String imagePath,
    required VoidCallback onDelete,
    Uint8List? imageBytes,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.orangePrimary, width: 1.3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 85,
                  width: 95,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.orangePrimary, width: 1.5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14.5),
                    child: imageBytes != null
                        ? Image.memory(imageBytes, fit: BoxFit.cover)
                        : Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.image_not_supported_outlined,
                              size: 40,
                              color: AppColors.blueNavy,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 8.5,
                  color: AppColors.textMuted,
                ),
              ),
              const Spacer(),
              const Divider(height: 10, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Estatus',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isAvailable ? AppColors.orangePrimary : const Color(0xFF34385A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isAvailable ? 'Disponible' : 'Agotado',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Botecito de basura en la esquina superior derecha
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: onDelete,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.orangePrimary, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  size: 16,
                  color: AppColors.orangePrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}