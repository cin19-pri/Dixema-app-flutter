import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/custom_bottom_nav.dart';
import 'gestion_screen.dart';
import 'product_repository.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final int _selectedNavIndex = 0; // "Dashboard" activo por defecto

  void _onNavTap(int index) {
    if (index == _selectedNavIndex) return;
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const GestionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ProductRepository.products;
    final availableCount = ProductRepository.availableCount;
    final totalCount = ProductRepository.totalProductsCount;
    final soldOutCount = ProductRepository.soldOutCount;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedNavIndex,
        onTap: _onNavTap,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          child: Column(
            children: [
              // Título "Dashbord" + línea naranja inferior
              const Text(
                'Dashbord',
                style: TextStyle(
                  color: AppColors.purpleDark,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 3.5,
                width: 240,
                decoration: BoxDecoration(
                  color: AppColors.orangePrimary.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 18),

              // Fila 1 de métricas sincronizadas con Gestión
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      value: '$availableCount',
                      label: 'Productos Disponibles',
                      borderColor: const Color(0xFFB5B7CE),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      value: '$totalCount',
                      label: 'Total De Productos',
                      borderColor: const Color(0xFFB5B7CE),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Fila 2 de métricas sincronizadas
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      value: '90',
                      label: 'Productos Vendidos',
                      borderColor: AppColors.orangePrimary.withOpacity(0.75),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      value: '$soldOutCount',
                      label: 'Productos Agotados',
                      borderColor: const Color(0xFFB5B7CE),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Contenedor grande: Gráfica + Productos de Gestión
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFB5B7CE),
                    width: 1.3,
                  ),
                ),
                child: Column(
                  children: [
                    // Recuadro interior de la gráfica con borde naranja
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColors.orangePrimary.withOpacity(0.75),
                          width: 1.3,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.orangePrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Indice de crecimiento de\nproductos vendidos',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Gráfica con ejes Y y X
                          SizedBox(
                            height: 175,
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('2500',
                                        style: TextStyle(
                                            fontSize: 9.5,
                                            color: AppColors.purpleDark)),
                                    Text('2000',
                                        style: TextStyle(
                                            fontSize: 9.5,
                                            color: AppColors.purpleDark)),
                                    Text('1500',
                                        style: TextStyle(
                                            fontSize: 9.5,
                                            color: AppColors.purpleDark)),
                                    Text('1000',
                                        style: TextStyle(
                                            fontSize: 9.5,
                                            color: AppColors.purpleDark)),
                                    Text('500',
                                        style: TextStyle(
                                            fontSize: 9.5,
                                            color: AppColors.purpleDark)),
                                    SizedBox(height: 14),
                                  ],
                                ),
                                const SizedBox(width: 8),

                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: CustomPaint(
                                          size: const Size(
                                              double.infinity, double.infinity),
                                          painter: _GrowthChartPainter(),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('50',
                                              style: TextStyle(
                                                  fontSize: 9.5,
                                                  color: AppColors.purpleDark)),
                                          Text('100',
                                              style: TextStyle(
                                                  fontSize: 9.5,
                                                  color: AppColors.purpleDark)),
                                          Text('150',
                                              style: TextStyle(
                                                  fontSize: 9.5,
                                                  color: AppColors.purpleDark)),
                                          Text('200',
                                              style: TextStyle(
                                                  fontSize: 9.5,
                                                  color: AppColors.purpleDark)),
                                          Text('250',
                                              style: TextStyle(
                                                  fontSize: 9.5,
                                                  color: AppColors.purpleDark)),
                                          Text('28',
                                              style: TextStyle(
                                                  fontSize: 9.5,
                                                  color: AppColors.purpleDark)),
                                          Text('29',
                                              style: TextStyle(
                                                  fontSize: 9.5,
                                                  color: AppColors.purpleDark)),
                                          Text('30',
                                              style: TextStyle(
                                                  fontSize: 9.5,
                                                  color: AppColors.purpleDark)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Tarjetas horizontales sincronizadas con Gestión
                    ...products.map((prod) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: _buildSoldProductTile(
                          name: prod['name'] as String,
                          price: prod['price'] as String,
                          soldCount: (prod['sold'] ?? '0') as String,
                          imagePath: prod['image'] as String,
                          imageBytes: prod['imageBytes'] as Uint8List?,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String value,
    required String label,
    required Color borderColor,
  }) {
    return Container(
      height: 84,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoldProductTile({
    required String name,
    required String price,
    required String soldCount,
    required String imagePath,
    Uint8List? imageBytes,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.orangePrimary.withOpacity(0.75),
          width: 1.3,
        ),
      ),
      child: Row(
        children: [
          // Miniatura real del producto (desde dispositivo o assets)
          Container(
            height: 46,
            width: 52,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: imageBytes != null
                  ? Image.memory(imageBytes, fit: BoxFit.cover)
                  : Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.laptop_mac_rounded,
                        color: AppColors.blueNavy,
                        size: 28,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),

          // Título y precio exacto de Gestión
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  price,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9.5,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Contador rojo/naranja a la derecha
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                soldCount,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD9534F),
                ),
              ),
              const Text(
                'Unidades Vendidas',
                style: TextStyle(
                  fontSize: 8.5,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GrowthChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.18)
      ..strokeWidth = 1;

    for (int i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final points = [
      Offset(0, size.height * 0.96),
      Offset(size.width * 0.16, size.height * 0.90),
      Offset(size.width * 0.30, size.height * 0.65),
      Offset(size.width * 0.36, size.height * 0.72),
      Offset(size.width * 0.56, size.height * 0.42),
      Offset(size.width * 0.62, size.height * 0.46),
      Offset(size.width * 0.72, size.height * 0.24),
      Offset(size.width * 0.79, size.height * 0.36),
      Offset(size.width * 0.85, size.height * 0.14),
      Offset(size.width * 0.91, size.height * 0.21),
      Offset(size.width * 0.97, size.height * 0.04),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    final linePaint = Paint()
      ..color = AppColors.orangePrimary
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, linePaint);

    final lastPoint = points.last;
    final haloPaint = Paint()
      ..color = AppColors.orangePrimary.withOpacity(0.20)
      ..style = PaintingStyle.fill;
    final dotPaint = Paint()
      ..color = AppColors.orangePrimary
      ..style = PaintingStyle.fill;

    canvas.drawCircle(lastPoint, 11, haloPaint);
    canvas.drawCircle(lastPoint, 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}