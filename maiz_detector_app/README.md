# maiz_detector_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



maiz_detector_app/
├── assets/               ✓ CREADA
│   ├── model/
│   │   └── 📄 labels.txt        
│   └── images/          ✓ CREADA
├── 📁 lib/                          # CÓDIGO FUENTE DE LA APLICACIÓN
│   │
│   ├── 📁 core/                     # CONFIGURACIONES Y CONSTANTES GLOBALES
│   │   ├── 📄 themes.dart           # 🎨 Define colores, estilos y tema visual de la app
│   │   └── 📄 constants.dart        # ⚙️  Constantes: rutas del modelo, nombres de clases, configuraciones
│   │
│   ├── 📁 data/                     # CAPA DE DATOS Y MODELOS
│   │   ├── 📁 models/               # 📊 Modelos de datos (estructuras)
│   │   │   └── 📄 detection_result.dart  # 🎯 Modelo para almacenar resultados de detección
│   │   └── 📁 repositories/         # 🗄️  Futuro: Conexión con bases de datos/APIs (vacío por ahora)
│   │
│   ├── 📁 domain/                   # LÓGICA DE NEGOCIO/APLICACIÓN
│   │   └── 📁 classifiers/          # 🧠 Inteligencia Artificial y Clasificación
│   │       └── 📄 tflite_classifier.dart  # 🤖 Clasificador IA (actualmente en modo simulación)
│   │
│   ├── 📁 presentation/             # INTERFAZ DE USUARIO (UI)
│   │   │
│   │   ├── 📁 home/                 # 🏠 PANTALLA PRINCIPAL
│   │   │   └── 📄 home_page.dart    # 📱 Pantalla de inicio con botones Cámara/Galería
│   │   │
│   │   ├── 📁 camera/               # 📷 FUNCIONALIDAD DE CÁMARA
│   │   │   └── 📄 camera_page.dart  # 🎥 Pantalla para tomar fotos y seleccionar de galería
│   │   │
│   │   ├── 📁 results/              # 📊 RESULTADOS Y DIAGNÓSTICO
│   │   │   ├── 📄 results_page.dart          # 📈 Pantalla que muestra el análisis de la imagen
│   │   │   └── 📁 widgets/                   # 🧩 Componentes reutilizables específicos de resultados
│   │   │       ├── 📄 disease_info_card.dart    # 💊 Tarjeta con información de la enfermedad detectada
│   │   │       └── 📄 recommendation_card.dart  # 💡 Tarjeta con recomendaciones de tratamiento
│   │   │
│   │   └── 📁 widgets/              # 🧱 COMPONENTES UI REUTILIZABLES (vacío por ahora)
│   │
│   ├── 📁 utils/                    # 🛠️  HERRAMIENTAS Y UTILIDADES
│   │   ├── 📄 image_utils.dart      # 🖼️  Funciones para procesar/manipular imágenes
│   │   ├── 📄 permission_utils.dart # 🔐 Funciones para manejar permisos (cámara, almacenamiento)
│   │   └── 📄 app_router.dart       # 🗺️  Configuración de navegación entre pantallas (FALTA CREAR)
│   │
│   └── 📄 main.dart                 # 🚀 PUNTO DE ENTRADA de la aplicación Flutter
│
├── 📁 assets/                       # RECURSOS ESTÁTICOS
│   ├── 📁 model/                    # 🤖 MODELOS DE IA
│   │   ├── 📄 model_unquant.tflite  # Modelo TensorFlow Lite (FUTURO: de Teachable Machine)
│   │   └── 📄 labels.txt            # Etiquetas de las clases que detecta el modelo
│   └── 📁 images/                   # 🖼️  IMÁGENES/ICONOS (vacío por ahora)
│
├── 📁 android/                      # ⚙️  CONFIGURACIÓN ESPECÍFICA PARA ANDROID
├── 📁 ios/                          # ⚙️  CONFIGURACIÓN ESPECÍFICA PARA iOS
├── 📄 pubspec.yaml                  # 📦 ARCHIVO DE DEPENDENCIAS (paquetes que usa la app)
└── 📄 README.md                     # 📖 DOCUMENTACIÓN DEL PROYECTO

