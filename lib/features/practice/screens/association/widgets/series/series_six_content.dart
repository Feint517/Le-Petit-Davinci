import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/features/practice/models/matching_item.dart';
import 'package:kids_learning_app/utils/constants/colors.dart'; // Ensure this path is correct

class SeriesSixContent extends GetView<AssociationController> {
  SeriesSixContent({super.key});

  // Key to get the RenderBox of the Stack for coordinate calculations
  final GlobalKey _stackKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 700;

    // It's good practice to react to the exercise changing,
    // or if it can be null, handle that case.
    return Obx(() {
      final exercise = controller.currentExercise as MatchingItem;
      // Remove the null check since exercise is guaranteed to be a MatchingItem
      return Column(
        children: [
          _buildHeader(
            context,
            isSmallScreen,
            exercise.title,
            exercise.instruction,
          ),
          _buildGameArea(context, exercise),
        ],
      );
    });
  }

  Widget _buildHeader(
    BuildContext context,
    bool isSmallScreen,
    String title,
    String instruction,
  ) {
    return SizedBox(
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
                    Icons.connect_without_contact,
                    color: AppColors.primaryDeep,
                    size: 30,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Bricolage Grotesque',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDeep,
                    ),
                    textAlign: TextAlign.center,
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
                onTap: () => _showInstructionsDialog(context, instruction),
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
                      Icons.info_outline,
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
    );
  }

  Widget _buildGameArea(BuildContext context, MatchingItem exercise) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7FF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE5CBFF), width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            18,
          ), // Match container's borderRadius - 2 (border width)
          child: Stack(
            key: _stackKey, // Assign the GlobalKey to the Stack
            children: [
              const DottedBackgroundPainterWidget(), // Use a separate widget for const
              _buildMatchingContent(context, exercise),
              _buildConnectionLines(exercise),
              _buildAnimatedConnectionLine(),
            ],
          ),
        ),
      ),
    );
  }

  void _showInstructionsDialog(BuildContext context, String instruction) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.white,
            title: const Text(
              "Instructions",
              style: TextStyle(
                fontFamily: 'Bricolage Grotesque',
                color: AppColors.primaryDeep,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              instruction,
              style: const TextStyle(fontFamily: 'Bricolage Grotesque'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "OK",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontFamily: 'Bricolage Grotesque',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildMatchingContent(BuildContext context, MatchingItem exercise) {
    final displayMode = exercise.displayMode;
    final leftPairs = exercise.pairs;
    // For stability, if rightPairs are shuffled, they should be shuffled once
    // in the controller when the exercise loads, or provide a consistent shuffle key.
    // Here, we assume the `exercise.pairs` for the right side is already prepared (e.g., a shuffled list)
    // or we shuffle it here. If shuffled here, ensure IDs are unique and mapping is correct.
    // final rightPairs = List<MatchPair>.from(exercise.pairs)..shuffle(math.Random(exercise.id.hashCode)); // Example of seeded shuffle
    final rightPairs = controller.getShuffledRightPairs(
      exercise,
    ); // Prefer controller managing this

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround, // Better distribution
              children:
                  leftPairs
                      .map(
                        (pair) => _buildMatchItem(
                          context: context,
                          itemPair: pair,
                          isLeft: true,
                          displayMode: displayMode,
                        ),
                      )
                      .toList(),
            ),
          ),
          const SizedBox(width: 20), // Spacer between columns
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  rightPairs
                      .map(
                        (pair) => _buildMatchItem(
                          context: context,
                          itemPair: pair,
                          isLeft: false,
                          displayMode: displayMode,
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchItem({
    required BuildContext context,
    required MatchPair itemPair,
    required bool isLeft,
    required String displayMode,
  }) {
    return Obx(
      () {
        // Check if this specific item is connected using the connectedToId property
        final bool isConnected = itemPair.connectedToId.value.isNotEmpty;

        // Item should be highlighted if it's the currently selected left item
        final bool isSelectedForHighlight =
            isLeft && controller.selectedLeftItemId.value == itemPair.id;

        // Determine if this item should be clickable
        bool isClickable = false;

        // During animation, nothing is clickable
        if (!controller.isAnimatingConnection.value) {
          if (isLeft) {
            // Left items are clickable if:
            // 1. They're not already connected AND
            // 2. Either no left item is selected OR this is the currently selected one
            isClickable =
                !isConnected &&
                (controller.selectedLeftItemId.value == null ||
                    controller.selectedLeftItemId.value == itemPair.id);
          } else {
            // Right items are clickable if:
            // 1. They're not already connected AND
            // 2. A left item is currently selected
            isClickable =
                !isConnected && controller.selectedLeftItemId.value != null;
          }
        }

        // Item should appear dimmed if it's connected or not clickable,
        // unless it's the currently selected left item
        bool dimmed = isConnected;
        if (!dimmed && !isClickable && !isSelectedForHighlight) {
          dimmed = true;
        }

        // Determine if this item is part of an incorrect match
        final bool isError =
            controller.isAnswerValidated.value &&
            isConnected &&
            !itemPair.isCorrect.value;

        return Builder(
          builder: (itemContext) {
            // itemContext is local to this item's build scope
            return GestureDetector(
              onTap: () {
                if (!isClickable) return;

                final RenderBox? stackRenderBox =
                    _stackKey.currentContext?.findRenderObject() as RenderBox?;
                if (stackRenderBox == null) return;

                final RenderBox itemRenderBox =
                    itemContext.findRenderObject() as RenderBox;
                Offset anchorPositionInStack;

                if (isLeft) {
                  anchorPositionInStack = itemRenderBox.localToGlobal(
                    Offset(
                      itemRenderBox.size.width,
                      itemRenderBox.size.height / 2,
                    ),
                    ancestor: stackRenderBox,
                  );
                  controller.selectItemForConnection(
                    itemPair.id,
                    true,
                    anchorPositionInStack,
                  );
                } else {
                  // Right item
                  anchorPositionInStack = itemRenderBox.localToGlobal(
                    Offset(0, itemRenderBox.size.height / 2),
                    ancestor: stackRenderBox,
                  );
                  controller.selectItemForConnection(
                    itemPair.id,
                    false,
                    anchorPositionInStack,
                  );
                }
              },
              child: Opacity(
                opacity: dimmed ? 0.4 : 1.0,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  padding: const EdgeInsets.all(
                    4.0,
                  ), // Padding for the highlight border effect
                  decoration:
                      isSelectedForHighlight
                          ? BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2.5,
                            ),
                            borderRadius: BorderRadius.circular(
                              14,
                            ), // Outer radius
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ],
                          )
                          : null,
                  child: Row(
                    mainAxisAlignment:
                        isLeft
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                    mainAxisSize:
                        MainAxisSize.min, // Important for Flexible children
                    children: [
                      if (isLeft) ...[
                        if (displayMode != 'text-only')
                          _buildItemCard(
                            imagePath: itemPair.leftImagePath,
                            isConnected: isConnected,
                            isCorrect:
                                controller.isAnswerValidated.value &&
                                itemPair.isCorrect.value,
                            isError: isError,
                          ),
                        if (displayMode == 'both') const SizedBox(width: 8),
                        if (displayMode != 'image-only')
                          Flexible(
                            child: _buildItemText(
                              itemPair.leftLabel,
                              isSelectedForHighlight,
                              isLeft,
                            ),
                          ),
                      ] else ...[
                        // Right item
                        if (displayMode != 'image-only')
                          Flexible(
                            child: _buildItemText(
                              itemPair.rightLabel,
                              false, // Right items don't get this "selected" text style
                              isLeft,
                            ),
                          ),
                        if (displayMode == 'both') const SizedBox(width: 8),
                        if (displayMode != 'text-only')
                          _buildItemCard(
                            imagePath: itemPair.rightImagePath,
                            isConnected: isConnected,
                            isCorrect:
                                controller.isAnswerValidated.value &&
                                itemPair.isCorrect.value,
                            isError: isError,
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }, // End of Obx
    );
  }

  Widget _buildItemText(
    String label,
    bool isSelectedForHighlight,
    bool isLeft,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color:
            isSelectedForHighlight
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
        border:
            isSelectedForHighlight
                ? Border.all(color: AppColors.primary.withValues(alpha: 0.5))
                : Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        label,
        textAlign: isLeft ? TextAlign.left : TextAlign.right,
        style: TextStyle(
          fontFamily: 'Bricolage Grotesque',
          fontSize: 15,
          fontWeight:
              isSelectedForHighlight ? FontWeight.bold : FontWeight.w600,
          color:
              isSelectedForHighlight ? AppColors.primaryDeep : Colors.black87,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2, // Allow for slightly longer text
      ),
    );
  }

  Widget _buildItemCard({
    required String imagePath,
    required bool isConnected,
    required bool isCorrect,
    required bool isError,
  }) {
    Color borderColor = Colors.grey.withValues(alpha: 0.4);
    double borderWidth = 1.5;
    List<BoxShadow>? boxShadow = [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        blurRadius: 5,
        offset: const Offset(0, 2),
      ),
    ];

    if (isConnected) {
      if (controller.isAnswerValidated.value) {
        borderColor = isCorrect ? Colors.green.shade400 : Colors.red.shade400;
        borderWidth = 2.5;
        boxShadow = [
          BoxShadow(
            color: (isCorrect ? Colors.green : Colors.red).withValues(alpha: 0.3),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ];
      } else {
        // Connected, but not yet validated
        borderColor = AppColors.primaryDeep.withValues(alpha: 0.7);
        borderWidth = 2.0;
        boxShadow = [
          BoxShadow(
            color: AppColors.primaryDeep.withValues(alpha: 0.25),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ];
      }
    }

    return Container(
      width: 65, // Slightly larger
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: boxShadow,
      ),
      padding: const EdgeInsets.all(6), // Adjust padding if image looks cramped
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder:
            (context, error, stackTrace) => const Icon(
              Icons.broken_image_outlined,
              color: Colors.grey,
              size: 30,
            ),
      ),
    );
  }

  Widget _buildConnectionLines(MatchingItem exercise) {
    // Only build if there are actual connections to draw
    if (exercise.pairs.every(
      (p) =>
          !p.isConnected.value ||
          p.leftPosition == Offset.zero ||
          p.rightPosition == Offset.zero,
    )) {
      return const SizedBox.shrink();
    }

    return CustomPaint(
      size: Size.infinite,
      painter: ConnectionsPainter(
        pairs: exercise.pairs,
        validated: controller.isAnswerValidated.value,
      ),
      isComplex: true,
      willChange: true,
      // ht: HitTestBehavior.translucent, // Add this line
    );
  }

  Widget _buildAnimatedConnectionLine() {
    return Obx(() {
      if (!controller.isAnimatingConnection.value ||
          controller.animatingLineStartPos.value == null ||
          controller.animatingLineEndPos.value == null) {
        return const SizedBox.shrink();
      }
      return CustomPaint(
        size: Size.infinite,
        painter: AnimatedConnectionPainter(
          start: controller.animatingLineStartPos.value!,
          end: controller.animatingLineEndPos.value!,
          progress: controller.animatedLineProgress.value,
        ),
      );
    });
  }
}

// --- Custom Painters ---

class DottedBackgroundPainterWidget extends StatelessWidget {
  const DottedBackgroundPainterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: DottedBackgroundPainter());
  }
}

class DottedBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.grey.withValues(alpha: 0.15) // Softer dots
          ..strokeWidth = 1.0;
    const spacing = 25.0; // Wider spacing
    for (double i = 0; i < size.width; i += spacing) {
      for (double j = 0; j < size.height; j += spacing) {
        canvas.drawCircle(Offset(i, j), 1.2, paint); // Slightly larger dots
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ConnectionsPainter extends CustomPainter {
  final List<MatchPair> pairs;
  final bool validated;

  ConnectionsPainter({required this.pairs, required this.validated});

  @override
  void paint(Canvas canvas, Size size) {
    final defaultPaint =
        Paint()
          ..color = AppColors.primaryDeep.withValues(alpha: 0.8)
          ..strokeWidth = 2.5
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final correctPaint =
        Paint()
          ..color = Colors.green.shade500
          ..strokeWidth =
              3.0 // Thicker for correct
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final errorPaint =
        Paint()
          ..color = Colors.red.shade500
          ..strokeWidth =
              3.0 // Thicker for error
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    for (var pair in pairs) {
      if (pair.isConnected.value &&
          pair.leftPosition != Offset.zero &&
          pair.rightPosition != Offset.zero) {
        final Paint currentPaint;
        if (validated) {
          currentPaint = pair.isCorrect.value ? correctPaint : errorPaint;
        } else {
          currentPaint = defaultPaint;
        }

        final path = Path();
        path.moveTo(pair.leftPosition.dx, pair.leftPosition.dy);

        final double controlPointX1 =
            pair.leftPosition.dx +
            (pair.rightPosition.dx - pair.leftPosition.dx) * 0.3;
        final double controlPointX2 =
            pair.leftPosition.dx +
            (pair.rightPosition.dx - pair.leftPosition.dx) * 0.7;

        path.cubicTo(
          controlPointX1,
          pair.leftPosition.dy, // Control point 1: horizontal from start
          controlPointX2,
          pair.rightPosition.dy, // Control point 2: horizontal from end
          pair.rightPosition.dx,
          pair.rightPosition.dy,
        );
        canvas.drawPath(path, currentPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant ConnectionsPainter oldDelegate) =>
      oldDelegate.pairs != pairs || oldDelegate.validated != validated;
}

class AnimatedConnectionPainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final double progress; // 0.0 to 1.0

  AnimatedConnectionPainter({
    required this.start,
    required this.end,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (start == Offset.zero || end == Offset.zero || progress == 0.0) return;

    final paint =
        Paint()
          ..color = AppColors.primary.withValues(alpha: 0.9) // Animation line color
          ..strokeWidth =
              3.5 // Prominent during animation
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    // Interpolate the end point of the curve based on progress
    // For a cubic Bezier, we need to interpolate all points or the path itself.
    // Simpler: interpolate the final 'end' point of the segment being drawn.
    final currentTargetX = start.dx + (end.dx - start.dx) * progress;
    final currentTargetY = start.dy + (end.dy - start.dy) * progress;

    final currentEnd = Offset(currentTargetX, currentTargetY);

    final path = Path();
    path.moveTo(start.dx, start.dy);

    // Adjust control points based on progress for a smoother growing curve effect
    final double controlPointX1 = start.dx + (currentEnd.dx - start.dx) * 0.3;
    final double controlPointX2 = start.dx + (currentEnd.dx - start.dx) * 0.7;

    path.cubicTo(
      controlPointX1,
      start.dy, // Control point 1 related to start.dy
      controlPointX2,
      currentEnd.dy, // Control point 2 related to currentEnd.dy
      currentEnd.dx,
      currentEnd.dy,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant AnimatedConnectionPainter oldDelegate) =>
      oldDelegate.start != start ||
      oldDelegate.end != end ||
      oldDelegate.progress != progress;
}

// Placeholder for your controller method to get shuffled pairs
// Add this to your AssociationController
/*
extension AssociationControllerUtils on AssociationController {
  List<MatchPair> getShuffledRightPairs(MatchingItem exercise) {
    // Create a new list from the original pairs to avoid modifying it directly
    var tempList = List<MatchPair>.from(exercise.pairs);
    // Shuffle it. You might want to use a seeded Random for consistency if needed
    // during development or for specific exercise behavior.
    tempList.shuffle(math.Random(exercise.id.hashCode % 1000)); // Example seeded shuffle
    return tempList;
  }
}
*/
