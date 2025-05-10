import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/features/practice/models/color_combination_item.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class SeriesThreeContent extends GetView<AssociationController> {
  const SeriesThreeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorCombinationItem exercise = controller.currentExercise;

    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrowScreen = screenWidth < 360;

    final circleSize = isNarrowScreen ? 50.0 : 70.0;

    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: isSmallScreen ? 110 : 130,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.palette,
                          color: AppColors.primary,
                          size: 30,
                        ),
                        const Gap(8),
                        Text(
                          "Combinaisons de Couleurs",
                          style: TextStyle(
                            fontFamily: 'Bricolage Grotesque',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDeep,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.toggleColorPalette(),
                      borderRadius: BorderRadius.circular(30),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7E5FF),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withValues(alpha: 0.2),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.color_lens_rounded,
                            color: Colors.purple,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: isSmallScreen ? 3 : 4,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFE5CBFF),
                        width: 2,
                      ),
                    ),
                    child:
                        isNarrowScreen
                            ? _buildCompactColorEquation(exercise, circleSize)
                            : _buildColorEquation(exercise, circleSize),
                  ),
                ),

                Expanded(
                  flex: isSmallScreen ? 4 : 5,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(8, 5, 8, 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7FF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFFFD6C9),
                        width: 2,
                      ),
                    ),
                    child:
                        controller.colorPaletteVisible.value
                            ? _buildColorPalette(context)
                            : Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.lightbulb_outline,
                                      color: Colors.amber,
                                      size: 24,
                                    ),
                                    const Gap(8),
                                    Text(
                                      exercise.instruction,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: 'Bricolage Grotesque',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.purple,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorEquation(ColorCombinationItem exercise, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildColorCircle(
          exercise.firstColorHex,
          exercise.firstColor,
          size,
          false,
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "+",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDeep,
            ),
          ),
        ),

        _buildColorCircle(
          exercise.secondColorHex,
          exercise.secondColor,
          size,
          false,
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "=",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDeep,
            ),
          ),
        ),

        _buildResultCircle(exercise, size),
      ],
    );
  }

  Widget _buildCompactColorEquation(
    ColorCombinationItem exercise,
    double size,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildColorCircle(
              exercise.firstColorHex,
              exercise.firstColor,
              size,
              false,
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "+",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDeep,
                ),
              ),
            ),

            _buildColorCircle(
              exercise.secondColorHex,
              exercise.secondColor,
              size,
              false,
            ),
          ],
        ),

        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "=",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDeep,
            ),
          ),
        ),

        _buildResultCircle(exercise, size),
      ],
    );
  }

  Widget _buildColorCircle(
    Color color,
    String colorName,
    double size,
    bool isAnimated,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const Gap(4),
        Text(
          colorName,
          style: const TextStyle(
            fontFamily: 'Bricolage Grotesque',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildResultCircle(ColorCombinationItem exercise, double size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (!controller.isAnswerValidated.value) {
              controller.toggleColorPalette();
            }
          },
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color:
                  controller.selectedColorAnswer.value != null
                      ? _getColorFromName(controller.selectedColorAnswer.value!)
                      : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child:
                  controller.selectedColorAnswer.value == null
                      ? const Center(
                        child: Icon(
                          Icons.touch_app,
                          color: Colors.grey,
                          size: 30,
                        ),
                      )
                      : controller.isAnswerValidated.value
                      ? Center(
                        child: Icon(
                          controller.selectedColorAnswer.value ==
                                  exercise.resultColor
                              ? Icons.check_circle
                              : Icons.cancel,
                          color:
                              controller.selectedColorAnswer.value ==
                                      exercise.resultColor
                                  ? Colors.green
                                  : Colors.red,
                          size: 30,
                        ),
                      )
                      : null,
            ),
          ),
        ),
        const Gap(4),
        Text(
          controller.selectedColorAnswer.value ?? "?",
          style: const TextStyle(
            fontFamily: 'Bricolage Grotesque',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildColorPalette(BuildContext context) {
    final List<Map<String, dynamic>> colorOptions = [
      {"name": "Rouge", "color": Colors.red},
      {"name": "Bleu", "color": Colors.blue},
      {"name": "Jaune", "color": Colors.yellow},
      {"name": "Vert", "color": Colors.green},
      {"name": "Violet", "color": Colors.purple},
      {"name": "Orange", "color": Colors.orange},
      {"name": "Rose", "color": const Color(0xFFFF69B4)},
      {"name": "Gris", "color": Colors.grey},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 6, bottom: 4),
          child: Row(
            children: const [
              Icon(Icons.palette, color: Color(0xFFFF9E80), size: 14),
              Gap(4),
              Text(
                "Palette de couleurs",
                style: TextStyle(
                  fontFamily: 'Bricolage Grotesque',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A3EA1),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFF7F7FF),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children:
                        colorOptions.map((option) {
                          return _buildColorOption(
                            option["color"],
                            option["name"],
                          );
                        }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColorOption(Color color, String name) {
    final isSelected = controller.selectedColorAnswer.value == name;

    return GestureDetector(
      onTap: () {
        if (!controller.isAnswerValidated.value) {
          controller.selectColorAnswer(name);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 6, bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isSelected ? Colors.black : Colors.black.withValues(alpha: 0.2),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ]
                  : null,
        ),
        child: Text(
          name,
          style: TextStyle(
            fontFamily: 'Bricolage Grotesque',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _getTextColorForBackground(color),
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }

  Color _getTextColorForBackground(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;
  }

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case "rouge":
        return Colors.red;
      case "bleu":
        return Colors.blue;
      case "jaune":
        return Colors.yellow;
      case "vert":
        return Colors.green;
      case "violet":
        return Colors.purple;
      case "orange":
        return Colors.orange;
      case "rose":
        return const Color(0xFFFF69B4);
      case "gris":
        return Colors.grey;
      case "blanc":
        return Colors.white;
      case "noir":
        return Colors.black;
      default:
        return Colors.white;
    }
  }
}
