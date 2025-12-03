import 'package:flutter/material.dart';

class DiseaseInfoCard extends StatelessWidget {
  final String diseaseType;
  
  const DiseaseInfoCard({
    super.key,
    required this.diseaseType,
  });

  @override
  Widget build(BuildContext context) {
    String description = '';
    List<String> symptoms = [];
    List<String> causes = [];

    // Información según el tipo de enfermedad
    if (diseaseType.contains('Enfermas')) {
      description = 'Las hojas presentan signos de enfermedad que pueden afectar el crecimiento de la planta.';
      symptoms = [
        'Manchas en las hojas',
        'Decoloración amarillenta',
        'Bordes secos o quemados',
        'Crecimiento anormal'
      ];
      causes = [
        'Infección por hongos (roya, tizón)',
        'Ataque de insectos',
        'Deficiencia nutricional',
        'Exceso o falta de riego'
      ];
    } else if (diseaseType.contains('Muertas')) {
      description = 'Las hojas están completamente secas o muertas. Esto puede indicar un problema grave.';
      symptoms = [
        'Hojas completamente secas',
        'Color marrón o negro',
        'Textura quebradiza',
        'Sin signos de vida'
      ];
      causes = [
        'Falta de agua prolongada',
        'Enfermedad avanzada',
        'Daño por heladas',
        'Intoxicación por químicos'
      ];
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: diseaseType.contains('Muertas') 
          ? Colors.red[50] 
          : Colors.orange[50],
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  diseaseType.contains('Muertas') 
                      ? Icons.warning 
                      : Icons.info_outline,
                  color: diseaseType.contains('Muertas')
                      ? Colors.red
                      : Colors.orange[800],
                ),
                const SizedBox(width: 10),
                Text(
                  diseaseType.contains('Muertas')
                      ? '⚠️ HOJAS MUERTAS - ATENCIÓN'
                      : 'ℹ️ INFORMACIÓN DE LA ENFERMEDAD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: diseaseType.contains('Muertas')
                        ? Colors.red
                        : Colors.orange[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Text(
              description,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 16),
            
            if (symptoms.isNotEmpty) ...[
              const Text(
                'Síntomas comunes:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...symptoms.map((symptom) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.circle, size: 8),
                    const SizedBox(width: 8),
                    Expanded(child: Text(symptom)),
                  ],
                ),
              )),
              const SizedBox(height: 16),
            ],
            
            if (causes.isNotEmpty) ...[
              const Text(
                'Posibles causas:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...causes.map((cause) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_right, size: 16),
                    const SizedBox(width: 4),
                    Expanded(child: Text(cause)),
                  ],
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }
}