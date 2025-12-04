import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/themes.dart';
import 'domain/classifiers/tflite_classifier.dart';
import 'utils/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<TFLiteClassifier>(
      create: (_) => TFLiteClassifier(),
      dispose: (_, classifier) => classifier.dispose(),
      child: MaterialApp(
        title: 'Detector de Maíz',
        theme: AppThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}