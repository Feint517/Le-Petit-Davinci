// series_seven_content.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/features/practice/models/counting_item.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class SeriesSevenContent extends GetView<AssociationController> {
  const SeriesSevenContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if we need to adjust layout for small screens
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

    return Column(
      children: [
        // Content area with title
        SizedBox(
          height: isSmallScreen ? 80 : 100,
          child: Stack(
            children: [
              // Center title and instruction
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.calculate_rounded,
                        color: AppColors.primary,
                        size: 30,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Compter les objets",
                        style: const TextStyle(
                          fontFamily: 'Bricolage Grotesque',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDeep,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Audio-like icon (for theme consistency)
              Positioned(
                top: 10,
                right: 10,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => {},
                    borderRadius: BorderRadius.circular(30),
                    child: Ink(
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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.help_outline,
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

        // Flexible layout for image and counting areas
        Expanded(
          child: Column(
            children: [
              // Image Area with objects to count
              Expanded(
                flex: isSmallScreen ? 5 : 6,
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
                  child: Column(
                    children: [
                      // Instruction text
                      Text(
                        controller.currentExercise.instruction,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Bricolage Grotesque',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.purple,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Image with objects to count
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            controller.currentExercise.imagePath,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[100],
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
                    ],
                  ),
                ),
              ),

              // Counting input area
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
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Obx(() => _buildCategoryInputs()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Build row of categories with counters
  Widget _buildCategoryInputs() {
    final categories = controller.currentExercise.categories;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate adaptive sizes based on available width
        final itemWidth =
            (constraints.maxWidth /
                (categories.length > 3 ? 3.2 : categories.length)) -
            5;

        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          separatorBuilder:
              (context, index) =>
                  SizedBox(width: itemWidth * 0.05), // Proportional spacing
          itemBuilder: (context, index) {
            final category = categories[index];
            return SizedBox(
              width: itemWidth,
              child: _buildCategoryCounter(category, itemWidth),
            );
          },
        );
      },
    );
  }

  // Build individual category counter
  Widget _buildCategoryCounter(CountingCategory category, double width) {
    // Calculate proportional sizes
    final iconSize = width * 0.8;
    final buttonSize = width * 0.25;

    return Obx(() {
      final isCorrect =
          controller.isAnswerValidated.value && category.isCorrect();
      final isIncorrect =
          controller.isAnswerValidated.value && !category.isCorrect();

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Category icon - now responsive
          Container(
            width: iconSize,
            height: iconSize,
            padding: EdgeInsets.all(width * 0.08),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color:
                    isCorrect
                        ? Colors.green
                        : isIncorrect
                        ? Colors.red
                        : Colors.grey.withOpacity(0.3),
                width: (isCorrect || isIncorrect) ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Image.asset(
              category.iconPath,
              fit: BoxFit.contain,
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, color: Colors.grey),
            ),
          ),
          SizedBox(height: width * 0.08),

          // Category name - adaptive font size
          Text(
            category.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Bricolage Grotesque',
              fontSize: width * 0.14,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryDeep,
            ),
          ),
          SizedBox(height: width * 0.08),

          // Counter controls - more compact
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Decrement button
                GestureDetector(
                  onTap:
                      controller.isAnswerValidated.value
                          ? null
                          : () {
                            if (category.userCount.value > 0) {
                              category.userCount.value--;
                            }
                          },
                  child: Container(
                    padding: EdgeInsets.all(width * 0.06),
                    decoration: BoxDecoration(
                      color:
                          controller.isAnswerValidated.value
                              ? Colors.grey.withOpacity(0.3)
                              : AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.remove,
                      size: buttonSize * 0.6,
                      color: AppColors.primaryDeep,
                    ),
                  ),
                ),

                // Count display
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.06),
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.1,
                    vertical: width * 0.06,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isCorrect
                            ? Colors.green.withOpacity(0.2)
                            : isIncorrect
                            ? Colors.red.withOpacity(0.2)
                            : Colors.white,
                    borderRadius: BorderRadius.circular(width * 0.1),
                    border: Border.all(
                      color:
                          isCorrect
                              ? Colors.green
                              : isIncorrect
                              ? Colors.red
                              : AppColors.primaryDeep.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "${category.userCount.value}",
                    style: TextStyle(
                      fontFamily: 'Bricolage Grotesque',
                      fontSize: width * 0.18,
                      fontWeight: FontWeight.bold,
                      color:
                          isCorrect
                              ? Colors.green
                              : isIncorrect
                              ? Colors.red
                              : AppColors.primaryDeep,
                    ),
                  ),
                ),

                // Increment button
                GestureDetector(
                  onTap:
                      controller.isAnswerValidated.value
                          ? null
                          : () {
                            if (category.userCount.value < 10) {
                              category.userCount.value++;
                            }
                          },
                  child: Container(
                    padding: EdgeInsets.all(width * 0.06),
                    decoration: BoxDecoration(
                      color:
                          controller.isAnswerValidated.value
                              ? Colors.grey.withOpacity(0.3)
                              : AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      size: buttonSize * 0.6,
                      color: AppColors.primaryDeep,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Correct/incorrect feedback
          if (controller.isAnswerValidated.value) ...[
            SizedBox(height: width * 0.08),
            Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              color: isCorrect ? Colors.green : Colors.red,
              size: width * 0.2,
            ),
          ],
        ],
      );
    });
  }
}
