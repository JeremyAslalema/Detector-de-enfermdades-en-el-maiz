import 'package:flutter/material.dart';
import 'package:maiz_detector_app/presentation/home/home_page.dart';
import 'package:maiz_detector_app/presentation/camera/camera_page.dart';
import 'package:maiz_detector_app/presentation/results/results_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      
      case '/camera':
        return MaterialPageRoute(builder: (_) => const CameraPage());
      
      case '/results':
        final args = settings.arguments as Map<String, dynamic>?;
        
        // Pasa los argumentos correctamente
        if (args != null && args['imagePath'] != null) {
          return MaterialPageRoute(
            builder: (_) => ResultsPage(imagePath: args['imagePath']),
          );
        }
        
        // Si no hay argumentos, mostrar página sin imagen
        return MaterialPageRoute(
          builder: (_) => const ResultsPage(imagePath: ''),
        );
      
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Página no encontrada'),
        ),
      ),
    );
  }

  // Métodos de navegación simplificados (AGREGAR ESTOS)
  static void goToCamera(BuildContext context) {
    Navigator.pushNamed(context, '/camera');
  }

  static void goToResults(BuildContext context, String imagePath) {
    Navigator.pushNamed(
      context,
      '/results',
      arguments: {'imagePath': imagePath},
    );
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static void goHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
      (route) => false,
    );
  }
}