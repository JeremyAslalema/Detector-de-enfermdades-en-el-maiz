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

class _ResultsPageState extends State<ResultsPage> with TickerProviderStateMixin {
  late String _imagePath;
  Map<String, double>? _predictions;
  bool _isLoading = true;
  String _topClass = '';
  double _topConfidence = 0.0;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadArguments();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _loadArguments() {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    if (args != null && args['imagePath'] != null) {
      _imagePath = args['imagePath'];
      _analyzeImage();
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _analyzeImage() async {
    try {
      final classifier = Provider.of<TFLiteClassifier>(context, listen: false);
      
      setState(() {
        _isLoading = true;
      });

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
        
        _fadeController.forward();
        _scaleController.forward();
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
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return const Color(0xFF689F38);
    if (confidence >= 0.6) return Colors.orange[700]!;
    return Colors.red[700]!;
  }

  String _getConfidenceText(double confidence) {
    if (confidence >= 0.8) return 'ALTA CONFIANZA';
    if (confidence >= 0.6) return 'CONFIANZA MEDIA';
    return 'BAJA CONFIANZA';
  }

  IconData _getConfidenceIcon(double confidence) {
    if (confidence >= 0.8) return Icons.verified_rounded;
    if (confidence >= 0.6) return Icons.warning_amber_rounded;
    return Icons.error_outline_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBE7),
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.analytics_rounded, size: 24),
            SizedBox(width: 10),
            Text('Resultados'),
          ],
        ),
        elevation: 0,
        backgroundColor: const Color(0xFF689F38),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _analyzeImage,
            tooltip: 'Re-analizar',
          ),
        ],
      ),
      body: _isLoading 
          ? _buildLoading()
          : Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF9FBE7),
                    Color(0xFFE8F5E9),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Imagen analizada
                      _buildImagePreview(),
                      const SizedBox(height: 24),
                      
                      // Resultado principal con animación
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: _buildMainResult(),
                      ),
                      const SizedBox(height: 24),
                      
                      // Todas las predicciones
                      _buildAllPredictions(),
                      const SizedBox(height: 24),
                      
                      // Información de la enfermedad
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
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildLoading() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF9FBE7),
            Color(0xFFE8F5E9),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF689F38).withAlpha(77),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: const CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF689F38)),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '🔍 Analizando imagen...',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF689F38),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Procesando con inteligencia artificial',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            
            // Indicadores de progreso
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: [
                  _buildLoadingStep('Cargando imagen', true),
                  _buildLoadingStep('Analizando características', true),
                  _buildLoadingStep('Generando diagnóstico', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingStep(String text, bool isComplete) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            isComplete ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isComplete ? const Color(0xFF689F38) : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isComplete ? const Color(0xFF689F38) : Colors.grey,
              fontWeight: isComplete ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(38),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.file(
              File(_imagePath),
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFFFD54F),
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(153),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: Colors.white, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Analizada',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainResult() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            _getConfidenceColor(_topConfidence).withAlpha(13),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _getConfidenceColor(_topConfidence).withAlpha(77),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: _getConfidenceColor(_topConfidence).withAlpha(51),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            // Badge de resultado
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _getConfidenceColor(_topConfidence).withAlpha(26),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _getConfidenceColor(_topConfidence).withAlpha(77),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getConfidenceIcon(_topConfidence),
                    color: _getConfidenceColor(_topConfidence),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _getConfidenceText(_topConfidence),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: _getConfidenceColor(_topConfidence),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Clase detectada
            Text(
              _getClassEmoji(_topClass),
              style: const TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 12),
            Text(
              _topClass.toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _getConfidenceColor(_topConfidence),
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            // Indicador circular mejorado
            Stack(
              alignment: Alignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 90,
                  lineWidth: 16,
                  percent: _topConfidence,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${(_topConfidence * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: _getConfidenceColor(_topConfidence),
                        ),
                      ),
                      Text(
                        'Precisión',
                        style: TextStyle(
                          fontSize: 14,
                          color: _getConfidenceColor(_topConfidence).withAlpha(179),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  progressColor: _getConfidenceColor(_topConfidence),
                  backgroundColor: _getConfidenceColor(_topConfidence).withAlpha(38),
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animationDuration: 1500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getClassEmoji(String className) {
    if (className.contains('Frutos')) return '🌽';
    if (className.contains('Sanas')) return '🍃';
    if (className.contains('Enfermas')) return '🦠';
    if (className.contains('Muertas')) return '🍂';
    if (className.contains('Inflorescencia')) return '🌸';
    return '🌱';
  }

  Widget _buildAllPredictions() {
    if (_predictions == null) return const SizedBox();
    
    final sortedPredictions = _predictions!.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FBE7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.bar_chart_rounded,
                    color: Color(0xFF689F38),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Todas las predicciones',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF689F38),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            ...sortedPredictions.asMap().entries.map((entry) {
              final index = entry.key;
              final prediction = entry.value;
              final isTop = index == 0;
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Posición
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isTop 
                                ? const Color(0xFF689F38)
                                : const Color(0xFFF9FBE7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isTop ? Colors.white : const Color(0xFF689F38),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                        // Nombre de clase
                        Expanded(
                          child: Text(
                            prediction.key,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: isTop ? FontWeight.bold : FontWeight.w500,
                              color: isTop ? const Color(0xFF689F38) : Colors.black87,
                            ),
                          ),
                        ),
                        
                        // Porcentaje
                        Text(
                          '${(prediction.value * 100).toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isTop ? const Color(0xFF689F38) : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Barra de progreso
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: prediction.value,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isTop ? const Color(0xFF689F38) : Colors.grey[400]!,
                        ),
                        minHeight: 8,
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
          child: _buildActionButton(
            icon: Icons.camera_alt_rounded,
            label: 'NUEVO ANÁLISIS',
            color: const Color(0xFF689F38),
            onPressed: () {
              Navigator.pushNamed(context, '/camera');
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton(
            icon: Icons.save_rounded,
            label: 'GUARDAR',
            color: const Color(0xFFFFD54F),
            iconColor: const Color(0xFF689F38),
            textColor: const Color(0xFF558B2F),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 12),
                      Text('¡Resultado guardado exitosamente!'),
                    ],
                  ),
                  backgroundColor: const Color(0xFF689F38),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    Color iconColor = Colors.white,
    Color textColor = Colors.white,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(77),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: textColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}