import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/helpers/asset_helper.dart';

class ImageTestScreen extends StatelessWidget {
  const ImageTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of image paths to test
    final imagePaths = [
      // Base shape images
      'assets/images/exercises/red_circle.png',
      'assets/images/exercises/blue_square.png',
      'assets/images/exercises/green_triangle.png',
      'assets/images/exercises/yellow_rectangle.png',
      
      // Colors folder images
      'assets/images/exercises/colors/red_circle.png',
      'assets/images/exercises/colors/blue_square.png',
      'assets/images/exercises/colors/green_triangle.png',
      'assets/images/exercises/colors/yellow_rectangle.png',
      
      // Animal images
      'assets/images/exercises/cat.png',
      'assets/images/exercises/dog.png',
      'assets/images/exercises/elephant.png',
      'assets/images/exercises/rabbit.png',
      'assets/images/exercises/bird_.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Loading Test'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Testing image asset loading',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            // Grid of test images
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                final path = imagePaths[index];
                return _buildImageTestCard(path);
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildImageTestCard(String imagePath) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  minHeight: 120,
                ),
                child: Builder(
                  builder: (context) {
                    debugPrint('Trying to load image: $imagePath');
                    try {
                      return AssetHelper.loadImageAsset(
                        path: imagePath,
                        fit: BoxFit.contain,
                        placeholder: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 30,
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Failed to load',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Path: $imagePath',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    } catch (e) {
                      debugPrint('Exception in test screen: $e');
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.broken_image_outlined,
                            color: Colors.orange,
                            size: 30,
                          ),
                          Text(
                            'Exception: ${e.toString().split('\n').first}',
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 40,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  imagePath.split('/').last,
                  style: const TextStyle(fontSize: 11),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}