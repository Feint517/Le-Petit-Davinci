// series_five_content.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'dart:math' as math;

// Helper for KColors if not already available
class KColors {
  static const Color primary = Color(0xFF6A3EA1);
  static const Color secondary = Color(0xFFE0B3FF);
  static const Color textPrimary = Color(0xFF6A3EA1);
  static const Color textSecondary = Colors.purple;
}

class SeriesFiveContent extends GetView<AssociationController> {
  const SeriesFiveContent({super.key});

  // Pre-defined configurations for text label positioning and rotation
  // Values are empirical and might need tuning for perfect alignment.
  // Angle on Circle: In radians, 0 is 3 o'clock, PI/2 is 12 o'clock (top).
  // Text Rotation: In radians, 0 is horizontal. Positive rotates counter-clockwise.
  static final List<Map<String, double>> _textLabelConfigs = [
    // Rouge (Outermost, index 0)
    {
      'angleOnCircle': 2.45,
      'textRotation': 0.75,
      'fontSize': 12.0,
    }, // approx 140 deg
    // Orange (Index 1)
    {
      'angleOnCircle': 2.2,
      'textRotation': 0.55,
      'fontSize': 12.0,
    }, // approx 126 deg
    // Jaune (Index 2)
    {
      'angleOnCircle': 1.95,
      'textRotation': 0.3,
      'fontSize': 12.0,
    }, // approx 112 deg
    // Vert (Index 3, Topmost)
    {
      'angleOnCircle': math.pi / 2,
      'textRotation': 0.0,
      'fontSize': 12.0,
    }, // 90 deg
    // Bleu (Index 4)
    {
      'angleOnCircle': math.pi / 2 - 0.25,
      'textRotation': -0.3,
      'fontSize': 12.0,
    }, // approx 78 deg
    // Indigo (Index 5)
    {
      'angleOnCircle': math.pi / 2 - 0.5,
      'textRotation': -0.55,
      'fontSize': 12.0,
    }, // approx 64 deg
    // Violet (Innermost, Index 6)
    {
      'angleOnCircle': math.pi / 2 - 0.75,
      'textRotation': -0.75,
      'fontSize': 12.0,
    }, // approx 43 deg
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Arc-en-ciel title label
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: KColors.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Arc-en-ciel",
              style: TextStyle(
                fontFamily: 'Bricolage Grotesque',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: KColors.textPrimary,
              ),
            ),
          ),
        ),

        // Title with palette icon
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.palette, color: KColors.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Les Couleurs de l'Arc-en-ciel",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: KColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Instruction text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            "Clique sur chaque nom de couleur et choisis la couleur de l'arc.",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Bricolage Grotesque',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: KColors.textSecondary,
            ),
          ),
        ),

        // Rainbow drawing area
        Expanded(
          child: Obx(
            () => Stack(
              alignment: Alignment.center,
              children: [
                // The Rainbow and its labels
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Ensure bands are available
                    if (controller.currentExercise.bands.isEmpty) {
                      return const Center(
                        child: Text("Chargement de l'arc-en-ciel..."),
                      );
                    }
                    return _buildRainbowWithLabels(context, constraints);
                  },
                ),

                // Color palette overlay when a band is selected
                if (controller.showColorPalette.value)
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: _buildColorPalette(context),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRainbowWithLabels(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    final bands = controller.currentExercise.bands;
    final numBands = bands.length;
    if (numBands == 0) return const SizedBox.shrink();

    // Determine the dimensions for the rainbow
    // The rainbow is a semicircle, so height is radius, width is diameter.
    // We want the rainbow to fit, using available width as the primary constraint.
    final double availableWidth =
        constraints.maxWidth * 0.9; // Use 90% of width to have some padding
    final double availableHeight = constraints.maxHeight * 0.9;

    // The radius of the outermost part of the entire rainbow structure
    final double outerMaxRadius = math.min(availableWidth / 2, availableHeight);

    if (outerMaxRadius <= 0) return const SizedBox.shrink(); // Not enough space

    final double rainbowDrawingHeight = outerMaxRadius;
    final double rainbowDrawingWidth = outerMaxRadius * 2;

    // Thickness of each band's "slot" (including the visual part and any implied spacing)
    // The image implies a small gap or just the black lines separating.
    // Let's consider the bandStrokeThickness as the main colored part.
    final double bandSlotThickness = outerMaxRadius / numBands + 20;
    final double bandVisualStrokeThickness =
        bandSlotThickness * 0.75; // The colored part's thickness
    final double outlineThickness = 1.5; // Black outline

    // Calculate geometries for each band (center radius, effective outer and inner for path)
    List<Map<String, double>> bandGeometries = [];
    for (int i = 0; i < numBands; i++) {
      // i=0 is the outermost band from the image's perspective (e.g., Rouge)
      // controller.bands[0] is "Rouge", bands[1] is "Orange" etc.
      double rOuterEdge = outerMaxRadius - (i * bandSlotThickness);
      double rInnerEdge = outerMaxRadius - ((i + 1) * bandSlotThickness);

      // For drawing the path, we need the actual outer and inner radii of the fillable area
      // The path will be filled, then stroked with black.
      bandGeometries.add({
        'pathOuterRadius': rOuterEdge,
        'pathInnerRadius': rInnerEdge,
        'textPlacementRadius':
            rInnerEdge + (bandSlotThickness / 2), // Mid-point for text
      });
    }

    final Offset rainbowCenterOffset = Offset(
      rainbowDrawingWidth / 2,
      rainbowDrawingHeight,
    );

    return SizedBox(
      width: rainbowDrawingWidth,
      height: rainbowDrawingHeight,
      child: Stack(
        alignment: Alignment.topCenter, // Painter draws from its top-left
        children: [
          // 1. CustomPaint for all rainbow arcs
          CustomPaint(
            size: Size(rainbowDrawingWidth, rainbowDrawingHeight),
            painter: RainbowArcPainter(
              bands: bands,
              bandGeometries: bandGeometries,
              outlineThickness: outlineThickness,
              completedBands:
                  controller.completedBands.toList(), // Pass as non-Rx list
              selectedBandIndex: controller.selectedBandIndex.value ?? -1,
              centerOffset:
                  rainbowCenterOffset, // Center for arcs (bottom-middle of its paint area)
            ),
          ),

          // 2. Text Labels on Arcs
          ...List.generate(numBands, (index) {
            final band = bands[index];
            final bandGeo = bandGeometries[index];
            final double textRadius = bandGeo['textPlacementRadius']!;

            final Color labelFixedColor = _getColorFromName(band.text);
            final config =
                _textLabelConfigs[index %
                    _textLabelConfigs
                        .length]; // Cycle if more bands than configs
            final double angleOnCircle = config['angleOnCircle']!;
            final double textRotation = config['textRotation']!;
            final double fontSize = config['fontSize']!;

            // Calculate (x,y) for the center of the text label.
            // Origin for math.cos/sin is 3 o'clock.
            // Painter/Stack origin is top-left. Rainbow center is (width/2, height).
            // textX = centerX + radius * cos(angle)
            // textY = centerY - radius * sin(angle) (because Y is positive downwards)
            double textCenterX =
                rainbowCenterOffset.dx + textRadius * math.cos(angleOnCircle);
            double textCenterY =
                rainbowCenterOffset.dy - textRadius * math.sin(angleOnCircle);

            return Positioned(
              left:
                  textCenterX -
                  50, // Provide a larger box for the Transform to work within
              top:
                  textCenterY -
                  20, // and for easier alignment of the text's center
              width: 100, // Arbitrary width for the Positioned box
              height: 40, // Arbitrary height
              child: Transform(
                alignment:
                    Alignment
                        .center, // Rotate around the center of the GestureDetector
                transform:
                    Matrix4.identity()
                      // ..translate(textCenterX, textCenterY) // Already handled by Positioned + Align
                      ..rotateZ(textRotation),
                child: Align(
                  // Align ensures the GestureDetector is centered at the conceptual point
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      if (!controller.completedBands.contains(index)) {
                        controller.selectBand(index);
                      }
                    },
                    child: Container(
                      // Optional: for better tap area or visual debugging
                      // color: Colors.black.withOpacity(0.1), // Debug tap area
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: Text(
                        band.text,
                        style: TextStyle(
                          fontFamily: 'Bricolage Grotesque',
                          fontSize: fontSize,
                          fontWeight: FontWeight.w600,
                          color: labelFixedColor,
                          shadows: const [
                            // Slight shadow for better readability
                            Shadow(
                              blurRadius: 1.0,
                              color: Colors.black26,
                              offset: Offset(0.5, 0.5),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case "rouge":
        return Colors.red;
      case "orange":
        return Colors.orange;
      case "jaune":
        return Colors.yellow;
      case "vert":
        return Colors.green;
      case "bleu":
        return Colors.blue;
      case "indigo":
        return const Color(0xFF4B0082); // Indigo
      case "violet":
        return Colors.purple;
      default:
        return Colors.black; // Fallback
    }
  }

  // Color palette widget (copied from original, assumed functional)
  Widget _buildColorPalette(BuildContext context) {
    final colorOptions = controller.currentExercise.colorOptions;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Choisis la couleur",
                style: TextStyle(
                  fontFamily: 'Bricolage Grotesque',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: KColors.textPrimary,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => controller.closeColorPalette(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children:
                colorOptions.map<Widget>((colorName) {
                  final color = controller.getColorFromName(
                    colorName,
                  ); // Use controller's helper
                  return GestureDetector(
                    onTap: () => controller.selectColor(colorName),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black.withOpacity(0.2),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: color.withOpacity(0.3),
                                blurRadius: 3,
                                spreadRadius: 0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          colorName,
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Bricolage Grotesque',
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}

class RainbowArcPainter extends CustomPainter {
  final List<dynamic>
  bands; // Assuming band has a 'text' and 'color' (when completed)
  final List<Map<String, double>>
  bandGeometries; // {'pathOuterRadius', 'pathInnerRadius'}
  final double outlineThickness;
  final List<int> completedBands;
  final int selectedBandIndex;
  final Offset
  centerOffset; // Center of the rainbow (bottom-middle of drawing area)

  RainbowArcPainter({
    required this.bands,
    required this.bandGeometries,
    required this.outlineThickness,
    required this.completedBands,
    required this.selectedBandIndex,
    required this.centerOffset,
  });

  Color _getColorFromName(
    String colorName, {
    Color defaultColor = Colors.grey,
  }) {
    // This should ideally come from a shared utility or the controller
    switch (colorName.toLowerCase()) {
      case "rouge":
        return Colors.red;
      case "orange":
        return Colors.orange;
      case "jaune":
        return Colors.yellow;
      case "vert":
        return Colors.green;
      case "bleu":
        return Colors.blue;
      case "indigo":
        return const Color(0xFF4B0082);
      case "violet":
        return Colors.purple;
      default:
        return defaultColor;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()..style = PaintingStyle.fill;
    final Paint strokePaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt; // Makes ends of arcs flat

    for (int i = 0; i < bands.length; i++) {
      final bandData = bands[i]; // This should be your band model
      final bandGeo = bandGeometries[i];
      final double outerR = bandGeo['pathOuterRadius']!;
      final double innerR = bandGeo['pathInnerRadius']!;

      if (outerR <= innerR || outerR <= 0) continue; // Invalid radius

      final bool isCompleted = completedBands.contains(i);
      final bool isSelected = selectedBandIndex == i && !isCompleted;

      // Define the path for the current arc segment
      Path path = Path();
      // Outer arc (left to right)
      path.arcTo(
        Rect.fromCircle(center: centerOffset, radius: outerR),
        math.pi,
        math.pi,
        false,
      );
      // Line from outer-right to inner-right (or use arcTo with correct radius and startAngle)
      // Inner arc (right to left) - sweep angle is negative
      path.arcTo(
        Rect.fromCircle(center: centerOffset, radius: innerR),
        0,
        -math.pi,
        false,
      );
      path.close(); // Connects inner-left to outer-left, forming the segment base

      // 1. Fill the band
      if (isCompleted) {
        fillPaint.color = _getColorFromName(
          bandData.text,
          defaultColor: bandData.color,
        ); // bandData.color is the target color
      } else {
        fillPaint.color = Colors.white; // Uncolored bands are white
      }
      canvas.drawPath(path, fillPaint);

      // 2. Draw black outline for all bands
      strokePaint.color = Colors.black;
      strokePaint.strokeWidth = outlineThickness;
      canvas.drawPath(path, strokePaint);

      // 3. Draw selection highlight if selected and not yet completed
      if (isSelected) {
        strokePaint.color = KColors.primary.withOpacity(
          0.8,
        ); // Purple highlight
        strokePaint.strokeWidth = outlineThickness + 2.0; // Thicker highlight
        canvas.drawPath(path, strokePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant RainbowArcPainter oldDelegate) {
    return oldDelegate.bands != bands ||
        oldDelegate.bandGeometries !=
            bandGeometries || // Could optimize if geo is static
        oldDelegate.completedBands != completedBands ||
        oldDelegate.selectedBandIndex != selectedBandIndex ||
        oldDelegate.centerOffset != centerOffset;
  }
}
