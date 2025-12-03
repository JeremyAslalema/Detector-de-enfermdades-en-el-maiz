import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePicture() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 85,
      );
      
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showError('Error tomando foto: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showError('Error seleccionando de galería: $e');
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

  void _analyzeImage() {
    if (_selectedImage != null) {
      Navigator.pushNamed(
        context, 
        '/results',
        arguments: {
          'imagePath': _selectedImage!.path,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Primero toma o selecciona una imagen'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📷 Capturar Imagen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Vista previa
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[300]!, width: 2),
              ),
              child: _buildPreview(),
            ),
            const SizedBox(height: 24),
            
            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botón de cámara
                _buildActionButton(
                  icon: Icons.camera_alt,
                  label: 'Tomar Foto',
                  onPressed: _takePicture,
                  color: const Color(0xFF2E7D32),
                ),
                
                // Botón de galería
                _buildActionButton(
                  icon: Icons.photo_library,
                  label: 'Galería',
                  onPressed: _pickFromGallery,
                  color: const Color(0xFF1976D2),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Botón de analizar
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _analyzeImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedImage != null 
                      ? const Color(0xFF2E7D32) 
                      : Colors.grey[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'ANALIZAR IMAGEN',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Instrucciones
            _buildInstructionsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview() {
    if (_selectedImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_camera, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Toma una foto o selecciona de galería',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(35),
          ),
          child: IconButton(
            icon: Icon(icon, size: 30, color: Colors.white),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionsCard() {
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
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.amber[700]),
                const SizedBox(width: 10),
                const Text(
                  'Consejos para mejores resultados:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTipItem('📸', 'Buena iluminación natural'),
            _buildTipItem('🎯', 'Enfoca bien la hoja o fruto'),
            _buildTipItem('🌿', 'Toma la foto cerca de la planta'),
            _buildTipItem('☀️', 'Evita sombras fuertes'),
            _buildTipItem('🔄', 'Puedes usar cámara o galería'),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'La app detectará:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('Frutos', style: TextStyle(fontSize: 12))),
                Chip(label: Text('Hojas Enfermas', style: TextStyle(fontSize: 12))),
                Chip(label: Text('Hojas Muertas', style: TextStyle(fontSize: 12))),
                Chip(label: Text('Hojas Sanas', style: TextStyle(fontSize: 12))),
                Chip(label: Text('Inflorescencia', style: TextStyle(fontSize: 12))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}