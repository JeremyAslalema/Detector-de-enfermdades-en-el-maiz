class DetectionResult {
  final String className;
  final double confidence;
  final DateTime timestamp;
  final String? imagePath;

  DetectionResult({
    required this.className,
    required this.confidence,
    required this.timestamp,
    this.imagePath,
  });

  // Método para saber si es un resultado confiable
  bool get isConfident => confidence >= 0.7;

  // Método para formatear la confianza como porcentaje
  String get confidencePercentage => '${(confidence * 100).toStringAsFixed(1)}%';

  // Factory method para crear desde JSON
  factory DetectionResult.fromJson(Map<String, dynamic> json) {
    return DetectionResult(
      className: json['className'],
      confidence: json['confidence'],
      timestamp: DateTime.parse(json['timestamp']),
      imagePath: json['imagePath'],
    );
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'className': className,
      'confidence': confidence,
      'timestamp': timestamp.toIso8601String(),
      'imagePath': imagePath,
    };
  }
}