import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/options_grid.dart';

class SeriesOneContent extends GetView<AssociationController> {
  const SeriesOneContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

    return Column(
      children: [
        SizedBox(
          height: isSmallScreen ? 110 : 130,
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Hero(
                    tag: controller.currentExercise.imagePath,
                    child: Image.asset(
                      controller.currentExercise.imagePath,
                      fit: BoxFit.contain,
                      height: isSmallScreen ? 100 : 120,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[100],
                          height: isSmallScreen ? 100 : 120,
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported,
                                size: 40,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Image non disponible",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7E5FF),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    _getSeriesTitle(),
                    style: const TextStyle(
                      fontFamily: 'Bricolage Grotesque',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple,
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
                flex: isSmallScreen ? 2 : 3,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE5CBFF),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      controller.currentExercise.instruction,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: isSmallScreen ? 5 : 6,
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
                  child: const OptionsGrid(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getSeriesTitle() {
    final seriesName = controller.selectedExercise.value;

    if (seriesName.contains("la bonne couleur")) {
      return "Les Couleurs";
    } else if (seriesName.contains("les animaux")) {
      return "Les Animaux";
    } else if (seriesName.contains("les fruits")) {
      return "Les Fruits";
    }

    return "Association";
  }
}
