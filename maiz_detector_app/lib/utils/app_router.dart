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
        return MaterialPageRoute(builder: (_) => const ResultsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Página no encontrada')),
          ),
        );
    }
  }

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