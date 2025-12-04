import 'package:flutter/material.dart';
import 'package:maiz_detector_app/utils/app_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF9FBE7),
              Color(0xFFE8F5E9),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  // Header animado con logo
                  _buildAnimatedHeader(),
                  const SizedBox(height: 40),

                  // Botones de acción principales
                  _buildActionButtons(context),
                  const SizedBox(height: 32),

                  // Tarjeta de información
                  _buildInfoCard(),
                  const SizedBox(height: 24),
                  
                  // Estadísticas rápidas
                  _buildQuickStats(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF689F38),
            Color(0xFF8BC34A),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF689F38).withAlpha(77), // 30% de opacidad
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            // Logo con efecto de resplandor
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD54F).withAlpha(153), // 60% de opacidad
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.agriculture,
                size: 70,
                color: Color(0xFF689F38),
              ),
            ),
            const SizedBox(height: 24),
            
            // Título principal
            const Text(
              '🌽 DETECTOR DE MAÍZ',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            
            // Subtítulo
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(51), // 20% de opacidad
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Análisis inteligente de cultivos',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        // Botón de cámara (principal)
        _buildMainActionButton(
          context: context,
          icon: Icons.camera_alt_rounded,
          title: 'TOMAR FOTO',
          subtitle: 'Captura en tiempo real',
          gradient: const LinearGradient(
            colors: [Color(0xFF689F38), Color(0xFF8BC34A)],
          ),
          onTap: () => AppRouter.goToCamera(context),
        ),
        const SizedBox(height: 16),
        
        // Botón de galería
        _buildMainActionButton(
          context: context,
          icon: Icons.photo_library_rounded,
          title: 'DESDE GALERÍA',
          subtitle: 'Selecciona una imagen',
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD54F), Color(0xFFFFE082)],
          ),
          iconColor: const Color(0xFF689F38),
          textColor: const Color(0xFF558B2F),
          onTap: () => AppRouter.goToCamera(context),
        ),
      ],
    );
  }

  Widget _buildMainActionButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    Color iconColor = Colors.white,
    Color textColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(38), // 15% de opacidad
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  // Ícono
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(64), // 25% de opacidad
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(width: 20),
                  
                  // Texto
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: textColor.withAlpha(229), // 90% de opacidad
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Flecha
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: iconColor,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFFFD54F),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD54F).withAlpha(77), // 30% de opacidad
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9C4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFF689F38),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  '¿Cómo funciona?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF689F38),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Pasos
            _buildStep(1, 'Captura una imagen clara', Icons.camera_alt_rounded),
            _buildStep(2, 'Análisis con IA instantáneo', Icons.analytics_rounded),
            _buildStep(3, 'Recibe diagnóstico preciso', Icons.check_circle_rounded),
            
            const SizedBox(height: 20),
            const Divider(height: 1),
            const SizedBox(height: 20),
            
            // Clases detectadas
            const Text(
              '🎯 Detectamos:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF558B2F),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildChip('🌽 Frutos', const Color(0xFFFFE082)),
                _buildChip('🍃 Hojas Sanas', const Color(0xFFC8E6C9)),
                _buildChip('🦠 Hojas Enfermas', const Color(0xFFFFCDD2)),
                _buildChip('🍂 Hojas Muertas', const Color(0xFFE0E0E0)),
                _buildChip('🌸 Inflorescencia', const Color(0xFFBBDEFB)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int number, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Número
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF689F38), Color(0xFF8BC34A)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF689F38).withAlpha(77), // 30% de opacidad
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Icono
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FBE7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 24,
              color: const Color(0xFF689F38),
            ),
          ),
          const SizedBox(width: 12),
          
          // Texto
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color.alphaBlend(color.withAlpha(128), Colors.white), // 50% de opacidad
          width: 1.5,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF558B2F),
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.speed_rounded,
            value: '<2s',
            label: 'Análisis',
            color: const Color(0xFF689F38),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            icon: Icons.precision_manufacturing_rounded,
            value: '95%',
            label: 'Precisión',
            color: const Color(0xFFFFD54F),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            icon: Icons.category_rounded,
            value: '5',
            label: 'Categorías',
            color: const Color(0xFF8BC34A),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(51), // 20% de opacidad
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}