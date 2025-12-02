// Constantes de la aplicación
class AppConstants {
  // Configuración del modelo
  static const String modelPath = 'assets/model/model_unquant.tflite';
  static const String labelsPath = 'assets/model/labels.txt';
  static const int inputSize = 224; // Tamaño de entrada del modelo
  static const double confidenceThreshold = 0.7; // 70% mínimo de confianza
  
  // Rutas de assets
  static const String logoPath = 'assets/images/logo.png';
  static const String cameraIcon = 'assets/images/camera_icon.png';
  static const String galleryIcon = 'assets/images/gallery_icon.png';
  
  // Nombres de clases (deben coincidir con labels.txt)
  static const List<String> classNames = [
    'Frutos',
    'Hojas Enfermas',
    'Hojas Muertas',
    'Hojas Sanas',
    'Inflorescencia'
  ];
  
  // Información de enfermedades (para mostrar en resultados)
  static Map<String, Map<String, dynamic>> diseaseInfo = {
    'Hojas Enfermas': {
      'description': 'La hoja presenta signos de enfermedad',
      'commonCauses': ['Hongos', 'Bacterias', 'Virus', 'Insectos'],
      'recommendation': 'Aplicar fungicida adecuado y aislar la planta',
      'severity': 'Media-Alta'
    },
    'Hojas Muertas': {
      'description': 'La hoja está completamente seca o muerta',
      'commonCauses': ['Falta de agua', 'Enfermedad avanzada', 'Daño severo'],
      'recommendation': 'Retirar hojas muertas y revisar riego',
      'severity': 'Alta'
    },
    'Hojas Sanas': {
      'description': 'La hoja se encuentra en buen estado',
      'commonCauses': [],
      'recommendation': 'Continuar con cuidados actuales',
      'severity': 'Baja'
    },
  };
}