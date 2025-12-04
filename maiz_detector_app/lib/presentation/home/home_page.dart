import 'package:flutter/material.dart';
import 'package:maiz_detector_app/utils/app_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.agriculture, size: 28),
            SizedBox(width: 10),
            Text('DETECTOR DE MAÍZ'),
          ],
        ),
        centerTitle: true,
      ),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Header con icono
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFFFD54F),
                          radius: 50,
                          child: Icon(
                            Icons.agriculture,
                            size: 60,
                            color: Color(0xFF689F38),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Bienvenido',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF689F38),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Analiza la salud de tus plantas de maíz',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Botones de acción
                Column(
                  children: [
                    _buildActionButton(
                      icon: Icons.camera_alt,
                      title: 'USAR CÁMARA',
                      subtitle: 'Toma una foto en tiempo real',
                      color: const Color(0xFF689F38),
                      onTap: () => AppRouter.goToCamera(context),
                    ),
                    const SizedBox(height: 16),
                    _buildActionButton(
                      icon: Icons.photo_library,
                      title: 'ELEGIR DE GALERÍA',
                      subtitle: 'Selecciona una foto existente',
                      color: const Color(0xFF8BC34A),
                      onTap: () => AppRouter.goToCamera(context),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Tarjeta informativa
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(
                      color: Color(0xFFFFD54F),
                      width: 2,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Color(0xFF689F38),
                            ),
                            SizedBox(width: 10),
                            Text(
                              '📋 Instrucciones:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF689F38),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        _InstructionStep(number: '1', text: 'Toma una foto clara de la hoja o fruto'),
                        _InstructionStep(number: '2', text: 'Espera a que se analice la imagen'),
                        _InstructionStep(number: '3', text: 'Recibe diagnóstico y recomendaciones'),
                        SizedBox(height: 20),
                        Divider(),
                        SizedBox(height: 16),
                        Text(
                          '🌽 Clases detectadas:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Chip(
                              label: Text('Frutos'),
                              backgroundColor: Color(0xFFFFF3E0),
                            ),
                            Chip(
                              label: Text('Hojas Enfermas'),
                              backgroundColor: Color(0xFFFFEBEE),
                            ),
                            Chip(
                              label: Text('Hojas Muertas'),
                              backgroundColor: Color(0xFFF5F5F5),
                            ),
                            Chip(
                              label: Text('Hojas Sanas'),
                              backgroundColor: Color(0xFFE8F5E9),
                            ),
                            Chip(
                              label: Text('Inflorescencia'),
                              backgroundColor: Color(0xFFE3F2FD),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color,
                const Color(0xFFFFD54F),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 28,
                  color: color,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstructionStep extends StatelessWidget {
  final String number;
  final String text;

  const _InstructionStep({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFFFD54F),
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: Color(0xFF689F38),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}