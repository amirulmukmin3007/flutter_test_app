import 'package:flutter/material.dart';

class CustomFullscreen extends StatefulWidget {
  const CustomFullscreen({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<CustomFullscreen> createState() => _CustomFullscreenState();
}

class _CustomFullscreenState extends State<CustomFullscreen> {
  final TransformationController _transformationController =
      TransformationController();

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              final currentScale = _transformationController.value
                  .getMaxScaleOnAxis();
              final newScale = (currentScale * 1.2).clamp(1.0, 4.0);
              _transformationController.value = Matrix4.identity()
                ..scale(newScale);
            },
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              final currentScale = _transformationController.value
                  .getMaxScaleOnAxis();
              final newScale = (currentScale * 0.8).clamp(1.0, 4.0);
              _transformationController.value = Matrix4.identity()
                ..scale(newScale);
            },
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          transformationController: _transformationController,
          minScale: 1.0,
          maxScale: 4.0,
          child: Image.network(widget.imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
