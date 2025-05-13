import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/lessons/controllers/alphabetController/alphabet_lesson_controller.dart'; 
import 'package:kids_learning_app/features/lessons/controllers/alphabetController/alphabet_prononciation_controller.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AlphabetPrononciation extends StatefulWidget {
  const AlphabetPrononciation({Key? key}) : super(key: key);

  @override
  State<AlphabetPrononciation> createState() => _AlphabetPrononciationState();
}

class _AlphabetPrononciationState extends State<AlphabetPrononciation>
    with TickerProviderStateMixin {
  // Animation controllers - reduced to only necessary ones
  late AnimationController _instructionAnimController;
  late List<AnimationController> _letterAnimControllers = [];

  // Controller
  late AlphabetPrononciationController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the GetX controller
    controller = Get.put(AlphabetPrononciationController());

    // Only keep necessary animation controllers
    _instructionAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    // Create animation controllers for each letter's subtle pulse
    _letterAnimControllers = List.generate(
      controller.letters.length,
      (index) =>
          AnimationController(vsync: this, duration: const Duration(seconds: 2))
            ..repeat(reverse: true),
    );
  }

  @override
  void dispose() {
    _instructionAnimController.dispose();
    for (var controller in _letterAnimControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background decoration elements
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.pink.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Main content
          Column(
            children: [ 
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Instruction text
                      Gap(20),
                      Container(
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.touch_app_rounded,
                                  color: AppColors.textPrimary,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Toucher une lettre pour entendre son son!",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "BricolageGrotesque",
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .animate(controller: _instructionAnimController)
                          .fadeIn(duration: Duration(milliseconds: 600))
                          .slideY(begin: -0.2, end: 0),
                    
                      Gap(10),
                    
                      // Letter Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 30,
                              mainAxisSpacing: 30,
                              childAspectRatio: 1,
                            ),
                        itemCount: controller.letters.length,
                        itemBuilder: (context, index) {
                          // Create staggered entry animation
                          final delay = Duration(milliseconds: index * 50);
                          final entranceAnim = AnimationController(
                            vsync: this,
                            duration: Duration(milliseconds: 400),
                          );
                    
                          // Start entrance animation after a delay
                          Future.delayed(delay, () {
                            if (mounted) entranceAnim.forward();
                          });
                    
                          return Obx(() {
                            // Reactive check if this letter is currently tapped
                            final bool isTapped =
                                controller.tappedLetterIndex.value == index;
                    
                            return GestureDetector(
                              onTap:
                                  () => controller.handleLetterTap(index),
                              child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          controller.borderColors[index]
                                              .withOpacity(0.9),
                                          controller.borderColors[index]
                                              .withOpacity(0.3),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller
                                              .borderColors[index]
                                              .withOpacity(
                                                isTapped ? 0.5 : 0.3,
                                              ),
                                          blurRadius: isTapped ? 12 : 8,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      controller.letters[index],
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: "BricolageGrotesque",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                  // Base subtle pulse animation (continuous)
                                  .animate(
                                    controller:
                                        _letterAnimControllers[index],
                                  )
                                  .scale(
                                    begin: Offset(1, 1),
                                    end: Offset(1.05, 1.05),
                                    duration: Duration(seconds: 2),
                                    curve: Curves.easeInOut,
                                  )
                                  // Initial entry animation (one-time)
                                  .animate(controller: entranceAnim)
                                  .fadeIn(
                                    duration: Duration(milliseconds: 400),
                                  )
                                  .slideY(
                                    begin: 0.3,
                                    end: 0,
                                    duration: Duration(milliseconds: 400),
                                  )
                                  // Tap animation (conditional)
                                  .animate(target: isTapped ? 1 : 0)
                                  .scale(
                                    begin: Offset(1, 1),
                                    end: Offset(1.3, 1.3),
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeOut,
                                  )
                                  .then()
                                  .scale(
                                    begin: Offset(1.3, 1.3),
                                    end: Offset(1, 1),
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  )
                                  // Additional feedback animation for children
                                  .then()
                                  .rotate(
                                    begin: 0,
                                    end: 0.05,
                                    duration: Duration(milliseconds: 100),
                                  )
                                  .then()
                                  .rotate(
                                    begin: 0.05,
                                    end: -0.05,
                                    duration: Duration(milliseconds: 100),
                                  )
                                  .then()
                                  .rotate(
                                    begin: -0.05,
                                    end: 0,
                                    duration: Duration(milliseconds: 100),
                                  ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
