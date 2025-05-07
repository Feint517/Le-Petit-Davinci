import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/home/controllers/subject_card_controller.dart';

class SubjectCard extends StatelessWidget {
  final String title;
  final String total;
  final String imagePath;
  final double progress;
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.title,
    required this.total,
    required this.imagePath,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      SubjectCardController(
        title: title,
        total: total,
        imagePath: imagePath,
        progress: progress,
        onTap: onTap,
      ),
      //* Use a unique tag to prevent conflicts with multiple SubjectCard instances
      tag: '${title}_${imagePath}_$progress',
    );

    return MouseRegion(
      onEnter: (_) => controller.onMouseEnter(),
      onExit: (_) => controller.onMouseExit(),
      child: GestureDetector(
        onTap: controller.onTap,
        child: AnimatedBuilder(
          animation: controller.scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: controller.scaleAnimation.value,
              child: Obx(
                () => Container(
                  width: 180,
                  height: 220,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color:
                            controller.isHovering.value
                                ? AppColors.primaryDeep.withValues(alpha: 0.3)
                                : AppColors.black.withValues(alpha: 0.2),
                        blurRadius: controller.isHovering.value ? 15 : 10,
                        offset:
                            controller.isHovering.value
                                ? const Offset(0, 5)
                                : const Offset(0, 1),
                        spreadRadius: controller.isHovering.value ? 1 : 0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        //* Background decoration
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: controller.getGradientColors(),
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                              ),
                            ),
                            child: const Opacity(opacity: 0.3),
                          ),
                        ),

                        //* Main content
                        Padding(
                          padding: const EdgeInsets.all(AppSizes.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //* Title and image row
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.black.withValues(
                                            alpha: 0.1,
                                          ),
                                          blurRadius: 5,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      controller.imagePath,
                                      height: 35,
                                      width: 35,
                                    ),
                                  ),
                                  const Spacer(),
                                  // Status pill showing if subject is active
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          controller.progress > 0
                                              ? const Color(0xFFE2F5E9)
                                              : Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      controller.progress > 0
                                          ? 'En cours'
                                          : 'Nouveau',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            controller.progress > 0
                                                ? const Color(0xFF34C759)
                                                : Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const Gap(20),

                              // Title with more emphasis
                              Text(
                                controller.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1A1A),
                                  fontFamily: 'BricolageGrotesque',
                                ),
                              ),

                              const Gap(8),

                              // Materials count
                              Text(
                                controller.total,
                                style: const TextStyle(
                                  color: Color(0xFF6B6B6B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              const Gap(24),

                              // Progress section
                              Row(
                                children: [
                                  const Text(
                                    'Progression',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF424242),
                                    ),
                                  ),
                                  const Spacer(),
                                  // Progress percentage pill
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: controller.getGradientColors(),
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      '${controller.progressPercent}%',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const Gap(8),

                              // Enhanced progress bar with animation
                              TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeInOut,
                                tween: Tween<double>(
                                  begin: 0,
                                  end: controller.progress,
                                ),
                                builder:
                                    (context, value, _) => Stack(
                                      children: [
                                        // Background
                                        Container(
                                          height: 12,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                            border: Border.all(
                                              color: Colors.grey[300]!,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        // Foreground (progress)
                                        Container(
                                          height: 12,
                                          width:
                                              value * (180 - (AppSizes.md * 2)),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors:
                                                  controller
                                                      .getGradientColors(),
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: controller
                                                    .getGradientColors()[0]
                                                    .withValues(alpha: 0.3),
                                                blurRadius: 3,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
