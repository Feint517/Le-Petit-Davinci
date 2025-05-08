// lib/common/widgets/feedback/lesson_result_screen.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class LessonResultScreen extends StatefulWidget {
  final bool isPerfect;
  final int totalXp;
  final int correctAnswers;
  final int totalQuestions;
  final VoidCallback onContinue;
  final String? customMessage;

  const LessonResultScreen({
    super.key,
    required this.isPerfect,
    required this.totalXp,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.onContinue,
    this.customMessage,
  });

  @override
  State<LessonResultScreen> createState() => _LessonResultScreenState();
}

class _LessonResultScreenState extends State<LessonResultScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Setup animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    
    // Scale animation for the mascot
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );
    
    // Fade animation for the text and buttons
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );
    
    // Start the animation
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final percentage = (widget.correctAnswers / widget.totalQuestions * 100).toInt();
    
    return Scaffold(
      backgroundColor: const Color(0xFF14191D), // Duolingo-like dark background
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              // Background sparkles or confetti if perfect
              if (widget.isPerfect)
                _buildConfetti(),
              
              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated mascot section
                    AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: child,
                        );
                      },
                      child: SizedBox(
                        height: 180,
                        width: screenSize.width * 0.8,
                        child: widget.isPerfect
                            ? Image.asset(ImageAssets.happy_owl) 
                            : Image.asset(ImageAssets.sad_owl),
                      ),
                    ),
                    
                    const SizedBox(height: AppSizes.lg),
                    
                    // Result text
                    AnimatedBuilder(
                      animation: _fadeAnimation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: child,
                        );
                      },
                      child: Column(
                        children: [
                          // Main message
                          Text(
                            widget.isPerfect ? "Perfect lesson!" : "Keep practicing!",
                            style: const TextStyle(
                              fontFamily: 'Bricolage Grotesque',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                          const SizedBox(height: AppSizes.sm),
                          
                          // Submessage
                          Text(
                            widget.customMessage ?? 
                                (widget.isPerfect 
                                    ? "You made no mistakes in this lesson" 
                                    : "You got ${widget.correctAnswers} out of ${widget.totalQuestions} correct"),
                            style: const TextStyle(
                              fontFamily: 'Bricolage Grotesque',
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                          
                          const SizedBox(height: AppSizes.xl),
                          
                          // Stats container
                          SizedBox(
                            width: screenSize.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // XP Stats
                                _buildStatCard(
                                  "TOTAL XP",
                                  "${widget.totalXp}",
                                  Colors.amber,
                                  Icons.bolt,
                                ),
                                
                                // Percentage Stats
                                _buildStatCard(
                                  percentage == 100 ? "AMAZING" : "COMPLETION",
                                  "$percentage%",
                                  Colors.green,
                                  Icons.check_circle,
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: AppSizes.xl),
                          
                          // Continue button
                          SizedBox(
                            width: 200,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: widget.onContinue,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryDeep,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "CONTINUE",
                                style: TextStyle(
                                  fontFamily: 'Bricolage Grotesque',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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
    );
  }
  
  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Bricolage Grotesque',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Bricolage Grotesque',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildConfetti() {
    return IgnorePointer(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Lottie.asset(
          LottieAssets.confetti,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}