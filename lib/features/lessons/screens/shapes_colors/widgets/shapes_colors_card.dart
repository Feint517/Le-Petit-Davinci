import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/features/lessons/models/shapes_colors_question.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class ShapesColorsCard extends StatefulWidget {
  final ShapesColorsQuestion question;
  final String? selectedAnswer;
  final Function(String) onAnswerSelected;
  final bool isAnswerChecked;
  final bool isCorrectAnswer;

  const ShapesColorsCard({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.onAnswerSelected,
    this.isAnswerChecked = false,
    this.isCorrectAnswer = false,
  });

  @override
  State<ShapesColorsCard> createState() => _ShapesColorsCardState();
}

class _ShapesColorsCardState extends State<ShapesColorsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isImageEnlarged = false;

  @override
  void initState() {
    super.initState();

    // Setup animation controller for image interactions
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ShapesColorsCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the question changes, reset the animation state
    if (oldWidget.question.id != widget.question.id) {
      _animationController.reset();
      _isImageEnlarged = false;
    }
  }

  void _toggleImageSize() {
    setState(() {
      _isImageEnlarged = !_isImageEnlarged;
      if (_isImageEnlarged) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Question section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question text with animated entrance
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question type indicator with animation
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.elasticOut,
                        builder: (context, value, child) {
                          return Transform.scale(scale: value, child: child);
                        },
                        child: _buildQuestionTypeIndicator(
                          widget.question.type,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Question text with fade-in animation
                      Expanded(
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 400),
                          builder: (context, value, child) {
                            return Opacity(opacity: value, child: child);
                          },
                          child: Text(
                            widget.question.question,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                              fontFamily: 'BricolageGrotesque',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(AppSizes.md),

                  // Interactive image area
                  Center(
                    child: GestureDetector(
                      onTap: _toggleImageSize,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: _isImageEnlarged ? 240 : 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color:
                                _isImageEnlarged
                                    ? _getColorForQuestionType(
                                      widget.question.type,
                                    )
                                    : Colors.grey.withValues(alpha: 0.2),
                            width: _isImageEnlarged ? 2 : 1,
                          ),
                          boxShadow:
                              _isImageEnlarged
                                  ? [
                                    BoxShadow(
                                      color: _getColorForQuestionType(
                                        widget.question.type,
                                      ).withValues(alpha: 0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                  : null,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: AnimatedBuilder(
                                animation: _scaleAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _scaleAnimation.value,
                                    child: child,
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.asset(
                                    widget.question.imagePath,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      // Fallback for missing images
                                      return const Center(
                                        child: Icon(
                                          Icons.image_not_supported_outlined,
                                          size: 64,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            // Zoom hint icon
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  _isImageEnlarged
                                      ? Icons.zoom_out_rounded
                                      : Icons.zoom_in_rounded,
                                  color: _getColorForQuestionType(
                                    widget.question.type,
                                  ),
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(AppSizes.md),

                  // Answer options grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: widget.question.options.length,
                    itemBuilder: (context, index) {
                      final option = widget.question.options[index];
                      final isSelected = widget.selectedAnswer == option;
                      final isCorrect = option == widget.question.correctAnswer;

                      // Determine colors based on selection state
                      Color backgroundColor;
                      Color borderColor;
                      Color textColor;

                      if (widget.isAnswerChecked) {
                        if (isCorrect) {
                          backgroundColor = Colors.green.withValues(
                            alpha: 0.15,
                          );
                          borderColor = Colors.green;
                          textColor = Colors.green.shade800;
                        } else if (isSelected && !isCorrect) {
                          backgroundColor = Colors.red.withValues(alpha: 0.15);
                          borderColor = Colors.red;
                          textColor = Colors.red.shade800;
                        } else {
                          backgroundColor = Colors.white;
                          borderColor = Colors.grey.withValues(alpha: 0.3);
                          textColor = Colors.grey.shade700;
                        }
                      } else {
                        if (isSelected) {
                          backgroundColor = AppColors.primaryDeep.withValues(
                            alpha: 0.15,
                          );
                          borderColor = AppColors.primaryDeep;
                          textColor = AppColors.primaryDeep;
                        } else {
                          backgroundColor = Colors.white;
                          borderColor = Colors.grey.withValues(alpha: 0.3);
                          textColor = Colors.grey.shade700;
                        }
                      }

                      // Add staggered animation to options
                      return TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 300 + (index * 100)),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Opacity(opacity: value, child: child),
                          );
                        },
                        child: GestureDetector(
                          onTap:
                              widget.isAnswerChecked
                                  ? null
                                  : () => widget.onAnswerSelected(option),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: borderColor, width: 2),
                              boxShadow:
                                  isSelected
                                      ? [
                                        BoxShadow(
                                          color: borderColor.withValues(
                                            alpha: 0.3,
                                          ),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                      : null,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (widget.isAnswerChecked && isCorrect)
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20,
                                    )
                                  else if (widget.isAnswerChecked &&
                                      isSelected &&
                                      !isCorrect)
                                    Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                      size: 20,
                                    )
                                  else if (isSelected)
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: AppColors.primaryDeep,
                                      size: 20,
                                    ),
                                  if (isSelected ||
                                      (widget.isAnswerChecked && isCorrect))
                                    const SizedBox(width: 8),
                                  Text(
                                    option,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                          isSelected ||
                                                  (widget.isAnswerChecked &&
                                                      isCorrect)
                                              ? FontWeight.bold
                                              : FontWeight.w500,
                                      color: textColor,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionTypeIndicator(QuestionType type) {
    IconData icon;
    Color color = _getColorForQuestionType(type);

    switch (type) {
      case QuestionType.shapeIdentification:
        icon = Icons.category_rounded;
        break;
      case QuestionType.colorIdentification:
        icon = Icons.color_lens_rounded;
        break;
      case QuestionType.combinedQuestion:
        icon = Icons.extension_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Color _getColorForQuestionType(QuestionType type) {
    switch (type) {
      case QuestionType.shapeIdentification:
        return AppColors.purple;
      case QuestionType.colorIdentification:
        return AppColors.orange;
      case QuestionType.combinedQuestion:
        return AppColors.accent;
    }
  }
}
