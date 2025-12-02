// lib/domain/classifiers/tflite_classifier.dart
class TFLiteClassifier {
  Future<void> initialize() async {
    // print('✅ Clasificador inicializado (modo simulación)');
  }

  Future<Map<String, double>> classifyImage(String imagePath) async {
    // Simulación temporal mientras arreglamos TFLite
    await Future.delayed(const Duration(seconds: 1));
    
    return {
      'Frutos': 0.1,
      'Hojas Enfermas': 0.85,
      'Hojas Muertas': 0.05,
      'Hojas Sanas': 0.08,
      'Inflorescencia': 0.02,
    };
  }

  Future<MapEntry<String, double>> getTopPrediction(String imagePath) async {
    final predictions = await classifyImage(imagePath);
    final topEntry = predictions.entries.reduce(
      (a, b) => a.value > b.value ? a : b,
    );
    return topEntry;
  }

  void dispose() {
    // print('🔴 Clasificador eliminado');
  }
}