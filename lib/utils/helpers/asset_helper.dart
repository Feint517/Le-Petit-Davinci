import 'package:flutter/material.dart';
//import 'package:kids_learning_app/utils/constants/assets_manager.dart';

/// Helper class for reliable asset loading with fallbacks
class AssetHelper {
  /// Load an image asset with robust error handling
  static Widget loadImageAsset({
    required String path,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Widget? placeholder,
    Color? color,
  }) {
    // Normalize path to ensure it starts with 'assets/'
    final normalizedPath = _normalizePath(path);
    
    return Image.asset(
      normalizedPath,
      width: width,
      height: height,
      fit: fit,
      color: color,
      // Show error in debug, but a nice fallback in production
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Error loading asset: $normalizedPath\nError: $error');
        return placeholder ?? _buildImageErrorWidget();
      },
    );
  }
  
  /// Normalize a path to ensure it has the correct format
  static String _normalizePath(String path) {
    // Handle string interpolation issues with constants
    if (path.contains(r'$')) {
      // Replace common string interpolation patterns
      path = path.replaceAll('\${IMAGE_PATH}', 'assets/images')
                 .replaceAll('\$IMAGE_PATH', 'assets/images')
                 .replaceAll('\${SVG_PATH}', 'assets/svgs')
                 .replaceAll('\$SVG_PATH', 'assets/svgs')
                 .replaceAll('\${ICONS_PATH}', 'assets/icons')
                 .replaceAll('\$ICONS_PATH', 'assets/icons')
                 .replaceAll('\${LOTTIE_PATH}', 'assets/lottie/misc')
                 .replaceAll('\$LOTTIE_PATH', 'assets/lottie/misc');
    }
    
    // If path doesn't start with 'assets/', add it
    if (!path.startsWith('assets/')) {
      if (path.startsWith('/assets/')) {
        return path.substring(1);
      } else if (path.startsWith('images/') || 
                 path.startsWith('icons/') || 
                 path.startsWith('svgs/') ||
                 path.startsWith('lottie/')) {
        return 'assets/$path';
      }
    }
    
    return path;
  }
  
  /// Create a friendly error widget for missing images
  static Widget _buildImageErrorWidget() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey,
        size: 24,
      ),
    );
  }
  
  /// Load an image directly from ImageAssets constants
  static Widget loadFromImageAssets({
    required String imageConstant,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Widget? placeholder,
    Color? color,
  }) {
    // Normalize the constant path
    final normalizedPath = _normalizePath(imageConstant);
    
    return loadImageAsset(
      path: normalizedPath,
      width: width,
      height: height,
      fit: fit,
      placeholder: placeholder,
      color: color,
    );
  }
}