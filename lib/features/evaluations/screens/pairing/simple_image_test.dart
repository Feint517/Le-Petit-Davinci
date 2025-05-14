import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/helpers/asset_helper.dart';

/// A very simple screen to test basic image loading
class SimpleImageTestScreen extends StatelessWidget {
  const SimpleImageTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Image Test'),
        backgroundColor: Colors.amber[100],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Testing basic image assets',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              
              // First test - most basic loading
              _buildTestSection(
                title: '1. AssetHelper Loading',
                description: 'Using AssetHelper.loadImageAsset',
                child: AssetHelper.loadImageAsset(
                  path: 'assets/images/exercises/red_circle.png',
                  height: 100,
                  width: 100,
                  placeholder: _buildErrorWidget(
                    'AssetHelper loading failed',
                    'Could not load image',
                  ),
                ),
              ),
              
              // Test with a network placeholder
              _buildTestSection(
                title: '2. Asset with Placeholder',
                description: 'Using FadeInImage with placeholder',
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/exercises/red_circle.png',
                  image: 'https://example.com/nonexistent.png', // This will fail on purpose
                  height: 100,
                  width: 100,
                  imageErrorBuilder: (context, error, stackTrace) {
                    // If placeholder loads, we'll see it instead of error
                    return const Center(
                      child: Text('Network image failed (expected)', 
                        style: TextStyle(color: Colors.orange)),
                    );
                  },
                ),
              ),
              
              // Test with widgets that contain images
              _buildTestSection(
                title: '3. Container with BoxDecoration',
                description: 'Using DecorationImage',
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/exercises/blue_square.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              
              // Test with raw image provider
              _buildTestSection(
                title: '4. Direct Colors Subfolder',
                description: 'Testing subfolder image directly',
                child: AssetHelper.loadImageAsset(
                  path: 'assets/images/exercises/colors/green_triangle.png',
                  height: 100,
                  width: 100,
                  placeholder: _buildErrorWidget(
                    'Colors subfolder failed',
                    'Could not load from colors subfolder',
                  ),
                ),
              ),
              
              // Test hardcoded path to compare with folder structure
              _buildTestSection(
                title: '5. Without assets/ prefix',
                description: 'Testing path normalization',
                child: AssetHelper.loadImageAsset(
                  path: 'images/exercises/yellow_rectangle.png', 
                  height: 100,
                  width: 100,
                  placeholder: _buildErrorWidget(
                    'Path normalization failed',
                    'Could not normalize path',
                  ),
                ),
              ),
              
              // Add a test for both locations of the same image
              _buildTestSection(
                title: '6. Root vs Subfolder Test',
                description: 'Comparing both image locations',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        AssetHelper.loadImageAsset(
                          path: 'assets/images/exercises/red_circle.png',
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(height: 4),
                        const Text('Root', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                    Column(
                      children: [
                        AssetHelper.loadImageAsset(
                          path: 'assets/images/exercises/colors/red_circle.png',
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(height: 4),
                        const Text('Subfolder', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Test with ImageAssets constant
              _buildTestSection(
                title: '7. Using Constants',
                description: 'ImageAssets.red_circle constant',
                child: Column(
                  children: [
                    AssetHelper.loadFromImageAssets(
                      imageConstant: ImageAssets.red_circle,
                      height: 70,
                      width: 70,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Constant value: ${ImageAssets.red_circle}',
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTestSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),
            Center(child: child),
          ],
        ),
      ),
    );
  }
  
  Widget _buildErrorWidget(String message, String error) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 40,
        ),
        const SizedBox(height: 8),
        Text(
          message,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(4),
          ),
          constraints: const BoxConstraints(maxWidth: 200),
          child: Text(
            error.split('\n').first,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}