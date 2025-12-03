import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  final String diseaseType;
  final double confidence;
  
  const RecommendationCard({
    super.key,
    required this.diseaseType,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    List<String> recommendations = [];
    String severity = 'Leve';
    Color severityColor = Colors.green;

    // Recomendaciones según el tipo
    if (diseaseType.contains('Sanas')) {
      recommendations = [
        'Continuar con el cuidado actual',
        'Mantener riego adecuado',
        'Observar regularmente las plantas',
        'Aplicar fertilizante balanceado cada 3 meses'
      ];
      severity = 'Leve';
      severityColor = Colors.green;
    } else if (diseaseType.contains('Enfermas')) {
      recommendations = [
        'Aislar la planta afectada',
        'Aplicar fungicida orgánico',
        'Reducir riego si hay exceso de humedad',
        'Podar las hojas muy afectadas',
        'Aplicar fertilizante rico en potasio'
      ];
      severity = 'Media';
      severityColor = Colors.orange;
    } else if (diseaseType.contains('Muertas')) {
      recommendations = [
        'Retirar inmediatamente las hojas muertas',
        'Revisar sistema de riego',
        'Analizar suelo para deficiencias',
        'Considerar replantar si es grave',
        'Consultar con especialista agrícola'
      ];
      severity = 'Alta';
      severityColor = Colors.red;
    } else if (diseaseType.contains('Frutos')) {
      recommendations = [
        'Los frutos están saludables',
        'Cosechar en su punto adecuado',
        'Almacenar en lugar fresco y seco',
        'Revisar regularmente para maduración'
      ];
      severity = 'Leve';
      severityColor = Colors.green;
    } else {
      recommendations = [
        'Continuar observación',
        'Mantener cuidados generales',
        'Documentar cambios en la planta'
      ];
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.lightGreen[50],
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.medical_services, color: Color(0xFF2E7D32)),
                const SizedBox(width: 10),
                const Text(
                  '💡 RECOMENDACIONES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: severityColor.withAlpha(51), // 20% opacity
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: severityColor),
                  ),
                  child: Text(
                    'GRAVEDAD: $severity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: severityColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            ...recommendations.asMap().entries.map((entry) {
              final index = entry.key;
              final recommendation = entry.value;
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        recommendation,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              );
            }),
            
            const SizedBox(height: 16),
            
            // Nota sobre confianza
            if (confidence < 0.7)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.amber),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Nota: La confianza es baja. Considera tomar otra foto con mejor iluminación o consultar con un experto.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}