import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/themes.dart';
import 'presentation/home/home_page.dart';
import 'domain/classifiers/tflite_classifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TFLiteClassifier>(
          create: (_) => TFLiteClassifier(),
          dispose: (_, classifier) => classifier.dispose(),
        ),
      ],
      child: MaterialApp(
        title: 'Detector de Maíz',
        theme: AppThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}