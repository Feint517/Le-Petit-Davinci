import 'package:flutter/material.dart';

class DebugImageTest extends StatelessWidget {
  const DebugImageTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Image Test'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildImageTestCard('Basic Shape - Circle', 'assets/images/exercises/shapes/circle.png'),
          const SizedBox(height: 16),
          _buildImageTestCard('Colored Shape - Red Circle', 'assets/images/exercises/colors/red_circle.png'),
          const SizedBox(height: 16),
          _buildImageTestCard('Multiple Shapes', 'assets/images/exercises/shapes_colors/multiple_shapes.png'),
          const SizedBox(height: 16),
          _buildImageTestCard('Alternate Path - Red Circle', 'assets/images/exercises/red_circle.png'),
        ],
      ),
    );
  }

  Widget _buildImageTestCard(String title, String imagePath) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Path: $imagePath',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('Error loading image: $imagePath');
                        debugPrint('Error details: $error');
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.broken_image,
                                color: Colors.red,
                                size: 48,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Failed to load image\n$imagePath',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}