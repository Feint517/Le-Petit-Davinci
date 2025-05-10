import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/features/practice/models/size_comparison_item.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class SeriesTwoContent extends GetView<AssociationController> {
  const SeriesTwoContent({super.key});

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
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getIconForGroup(
                          controller.currentExercise.itemGroup.groupName,
                        ),
                        color: AppColors.primaryDeep,
                        size: 30,
                      ),
                      const Gap(8),
                      Text(
                        controller.currentExercise.itemGroup.groupName,
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
                        color: Colors.purple.withValues(alpha: 0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    controller.currentExercise.itemGroup.category,
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
                  child: _buildSizeOptions(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getIconForGroup(String groupName) {
    switch (groupName.toLowerCase()) {
      case "hippopotames":
      case "cerfs":
      case "chiens":
      case "pandas":
        return Icons.pets;
      case "vélos":
        return Icons.directions_bike;
      case "marteaux":
        return Icons.hardware;
      case "lunettes":
        return Icons.visibility;
      case "stylos":
        return Icons.edit;
      default:
        return Icons.category;
    }
  }

  Widget _buildSizeOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final imageAreaWidth = constraints.maxWidth / 3;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                controller.currentExercise.itemGroup.sizeOptions
                    .map<Widget>(
                      (option) => _buildSelectableItem(
                        context,
                        controller.currentExercise.itemGroup,
                        option,
                        '${controller.currentExercise.itemGroup.groupName}_${option.size}',
                        imageAreaWidth,
                      ),
                    )
                    .toList(),
          );
        },
      ),
    );
  }

  Widget _buildSelectableItem(
    BuildContext context,
    ItemGroup group,
    SizeOption option,
    String itemId,
    double areaWidth,
  ) {
    final imageSize = areaWidth * option.scale * 0.9;

    final isSelected = option.isLargestSelected;

    final isCorrectAnswer = option.size == "grand";

    return SizedBox(
      width: areaWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Obx(
            () => Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (!controller.isAnswerValidated.value) {
                    controller.selectLargestItem(option.size);
                  }
                },
                borderRadius: BorderRadius.circular(20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow:
                        isSelected.value
                            ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.6),
                                blurRadius: 12,
                                spreadRadius: 2,
                                offset: const Offset(0, 0),
                              ),
                            ]
                            : null,
                  ),
                  child: Center(
                    child: Image.asset(
                      group.imagePath,
                      height: imageSize,
                      width: imageSize,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.transparent,
                          height: imageSize,
                          width: imageSize,
                          child: Icon(
                            Icons.image_not_supported,
                            size: imageSize / 2.5,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),

          if (controller.isAnswerValidated.value && isSelected.value) ...[
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isCorrectAnswer ? AppColors.accent : Colors.redAccent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  isCorrectAnswer ? Icons.check : Icons.close,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
