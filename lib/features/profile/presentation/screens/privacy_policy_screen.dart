import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool _accepted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // Header con flecha, título y logo
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.orangePrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.purpleDark,
                        ),
                        children: [
                          TextSpan(text: 'Compromisos de\n'),
                          TextSpan(
                            text: 'Dixema',
                            style: TextStyle(color: AppColors.orangePrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 45,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.shield_outlined,
                      color: AppColors.orangePrimary,
                      size: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Contenedor scrolleable con borde naranja
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.orangePrimary, width: 1.5),
                  ),
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(right: 8),
                      child: const Text(
                        '''El objetivo de estas políticas es proteger los datos de tus usuarios (PYMES) y garantizar la confiabilidad de tu servicio (Disponibilidad, Integridad, Confidencialidad).

1. Políticas de Seguridad del Acceso y la Autenticación
Estas políticas regulan cómo los usuarios (empleados de las PYMES, administradores de Dixema) acceden a la aplicación y a los datos.
• Política de Contraseñas Seguras:
  - Requisito: Establecer reglas estrictas de complejidad (mínimo 10-12 caracteres, uso de mayúsculas, minúsculas, números y símbolos).
  - Prohibición: No permitir contraseñas basadas en información personal o palabras comunes (ej. "Dixema2025").
  - Cambio: Requerir el cambio de contraseña al menos cada 90 días.
• Autenticación Multifactor (MFA/2FA):
  - Requisito: Implementar obligatoriamente la MFA (por SMS, aplicación o correo) para todos los usuarios con roles de administrador o acceso a datos financieros.
• Gestión de Sesiones:
  - Tiempo Límite: Cerrar automáticamente la sesión del usuario después de 15-30 minutos de inactividad para evitar el acceso no autorizado si el dispositivo queda desatendido.
• Principio de Mínimo Privilegio:
  - Restricción: Solo otorgar a los usuarios (dentro de las PYMES) el acceso a los datos y funcionalidades que son estrictamente necesarias para sus tareas (ej. el vendedor no necesita ver los datos contables del administrador).

2. Políticas de Manejo y Protección de Datos
Estas políticas son el corazón de la protección de la información sensible de las PYMES.
• Clasificación de la Información:
  - Definir categorías de datos (ej. Públicos, Internos, Confidenciales - datos de clientes/precios, Estrictamente Confidenciales - datos financieros/claves de pago).
  - Establecer cómo Dixema debe proteger cada tipo de dato.
• Cifrado de Datos (Encryption):
  - Datos en Tránsito: Utilizar siempre el protocolo TLS/SSL (HTTPS) para cifrar la comunicación entre la aplicación móvil/web y las servidores de Dixema.
  - Declarar el compromiso de Dixema con las leyes de protección de datos personales y comerciales aplicables en las regiones donde operen (ej. GDPR si operan en Europa, o leyes locales).''',
                        style: TextStyle(fontSize: 11.5, color: AppColors.textDark, height: 1.45),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Checkbox circular inferior de aceptación
              GestureDetector(
                onTap: () => setState(() => _accepted = !_accepted),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: _accepted
                          ? const Icon(Icons.check, color: Colors.black87, size: 20)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Acepto las Políticas de Privacidad',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}