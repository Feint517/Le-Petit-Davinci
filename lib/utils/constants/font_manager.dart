
import 'package:flutter/material.dart';

class FontScale {
  static double getScaleFactor(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    
    // Define your breakpoints
    if (width < 350) return 0.75;    // Small phones
    if (width < 400) return 0.9;     // Medium-small
    if (width < 600) return 1.0;     // Normal phones
    if (width < 900) return 1.25;    // Large phones/tablets
    return 1.5;                      // Extra large tablets
  }

  static Widget scaleBuilder(
    BuildContext context, 
    Widget? child,
    Widget Function(BuildContext, Widget?) originalBuilder,
  ) {
    final scale = getScaleFactor(context);
    final originalChild = originalBuilder(context, child);
    
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: scale,
      ),
      child: originalChild,
    );
  }
}