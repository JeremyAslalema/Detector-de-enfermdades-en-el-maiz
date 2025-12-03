import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../../domain/classifiers/tflite_classifier.dart';
import 'widgets/disease_info_card.dart';
import 'widgets/recommendation_card.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late String _imagePath;
  Map<String, double>? _predictions;
  bool _isLoading = true;
  String _topClass = '';
  double _topConfidence = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadArguments();
    });
  }

  void _loadArguments() {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    if (args != null && args['imagePath'] != null) {
      _imagePath = args['imagePath'];
      _analyzeImage();
    } else {
      // Si no hay imagen, regresar
      Navigator.pop(context);
    }
  }

  Future<void> _analyzeImage() async {
    try {
      final classifier = Provider.of<TFLiteClassifier>(context, listen: false);
      
      setState(() {
        _isLoading = true;
      });

      // Usar el clasificador (simulación por ahora)
      _predictions = await classifier.classifyImage(_imagePath);
      
      if (_predictions != null && _predictions!.isNotEmpty) {
        final topEntry = _predictions!.entries.reduce(
          (a, b) => a.value > b.value ? a : b,
        );
        
        setState(() {
          _topClass = topEntry.key;
          _topConfidence = topEntry.value;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError('Error analizando imagen: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return Colors.green;
    if (confidence >= 0.6) return Colors.orange;
    return Colors.red;
  }

  String _getConfidenceText(double confidence) {
    if (confidence >= 0.8) return 'ALTA CONFIANZA';
    if (confidence >= 0.6) return 'CONFIANZA MEDIA';
    return 'BAJA CONFIANZA';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 Resultados'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _analyzeImage,
          ),
        ],
      ),
      body: _isLoading 
          ? _buildLoading()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagen analizada
                  _buildImagePreview(),
                  const SizedBox(height: 24),
                  
                  // Resultado principal
                  _buildMainResult(),
                  const SizedBox(height: 24),
                  
                  // Todas las predicciones
                  _buildAllPredictions(),
                  const SizedBox(height: 24),
                  
                  // Información de la enfermedad (si aplica)
                  if (_topClass.contains('Enfermas') || _topClass.contains('Muertas'))
                    DiseaseInfoCard(diseaseType: _topClass),
                  
                  const SizedBox(height: 16),
                  
                  // Recomendaciones
                  RecommendationCard(
                    diseaseType: _topClass,
                    confidence: _topConfidence,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Botones de acción
                  _buildActionButtons(),
                ],
              ),
            ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text(
            'Analizando imagen...',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 10),
          Text(
            'Esto puede tomar unos segundos',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          File(_imagePath),
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMainResult() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              _topClass.toUpperCase(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            
            // Indicador de porcentaje
            CircularPercentIndicator(
              radius: 80,
              lineWidth: 15,
              percent: _topConfidence,
              center: Text(
                '${(_topConfidence * 100).toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              progressColor: _getConfidenceColor(_topConfidence),
              backgroundColor: Colors.grey[200]!,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            
            const SizedBox(height: 16),
            
            // Texto de confianza
            Text(
              _getConfidenceText(_topConfidence),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _getConfidenceColor(_topConfidence),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllPredictions() {
    if (_predictions == null) return const SizedBox();
    
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📈 Todas las predicciones:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            
            ..._predictions!.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.key,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Text(
                      '${(entry.value * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: entry.key == _topClass 
                            ? const Color(0xFF2E7D32)
                            : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/camera');
            },
            icon: const Icon(Icons.camera_alt),
            label: const Text('NUEVA ANÁLISIS'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Color(0xFF2E7D32)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Guardar resultado
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Resultado guardado')),
              );
            },
            icon: const Icon(Icons.save),
            label: const Text('GUARDAR'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}