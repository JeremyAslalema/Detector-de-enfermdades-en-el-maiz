import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌽 Detector de Maíz'),
        centerTitle: true,
        elevation: 4,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo o icono
              const Icon(
                Icons.agriculture,
                size: 100,
                color: Color(0xFF2E7D32),
              ),
              const SizedBox(height: 30),
              
              // Título
              const Text(
                'Bienvenido',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(height: 10),
              
              Text(
                'Analiza la salud de tus plantas de maíz',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // Botón para cámara
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/camera');
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text(
                    'USAR CÁMARA',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Botón para galería
              SizedBox(
                width: double.infinity,
                height: 60,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/camera');
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text(
                    'ELEGIR DE GALERÍA',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFF2E7D32),
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              // Información
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📋 Instrucciones:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '1. Toma una foto clara de la hoja o fruto\n'
                        '2. Espera a que se analice la imagen\n'
                        '3. Recibe el diagnóstico y recomendaciones',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Clases detectadas:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          Chip(label: Text('Frutos')),
                          Chip(label: Text('Hojas Enfermas')),
                          Chip(label: Text('Hojas Muertas')),
                          Chip(label: Text('Hojas Sanas')),
                          Chip(label: Text('Inflorescencia')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}