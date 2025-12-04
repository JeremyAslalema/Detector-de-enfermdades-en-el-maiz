class AppConstants {
  // Rutas del modelo
  static const String modelPath = 'assets/model/model_unquant.tflite';
  static const String modelLabelsPath = 'assets/model/labels.txt';
  
  // Nombres de clases
  static const String healthyLeaves = 'HOJAS SANAS';
  static const String sickLeaves = 'HOJAS ENFERMAS';
  static const String deadLeaves = 'HOJAS MUERTAS';
  static const String fruits = 'FRUTOS';
  static const String inflora = 'INFLORA';
  
  static List<String> get allClasses => [
    healthyLeaves,
    sickLeaves,
    deadLeaves,
    fruits,
    inflora,
  ];
  
  // Configuración
  static const double minConfidenceThreshold = 0.5;
  static const int maxHistoryItems = 10;
}