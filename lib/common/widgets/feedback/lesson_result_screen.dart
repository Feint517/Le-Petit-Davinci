// lib/common/widgets/feedback/lesson_result_screen.dart
import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

/// Model for animated floating particles
class ParticleModel {
  final int id;
  double x;
  double y;
  final double size;
  final Color color;
  final int shape; // 0: circle, 1: square, 2: triangle
  double speedX;
  double speedY;
  double opacity;
  
  ParticleModel({
    required this.id,
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.shape,
    required this.speedX,
    required this.speedY,
    required this.opacity,
  });
}

/// Floating object for kids
class FloatingObject {
  final IconData icon;
  final Color color;
  final double size;
  final double x;
  final double y;
  final double rotationSpeed;
  
  FloatingObject({
    required this.icon,
    required this.color,
    required this.size,
    required this.x,
    required this.y,
    required this.rotationSpeed,
  });
}

/// Sparkle effect for kid-friendly animations
class SparkleWidget extends StatelessWidget {
  final double size;
  final Color color;
  final Animation<double> animation;
  
  const SparkleWidget({
    Key? key,
    required this.size,
    required this.color,
    required this.animation,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: math.sin(animation.value * math.pi) * 0.8 + 0.2,
          child: Transform.rotate(
            angle: animation.value * math.pi * 2,
            child: CustomPaint(
              size: Size(size, size),
              painter: StarPainter(color: color),
            ),
          ),
        );
      },
    );
  }
}

/// Star shape painter
class StarPainter extends CustomPainter {
  final Color color;
  
  StarPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    final path = Path();
    final angleStep = math.pi / 5;
    
    for (int i = 0; i < 10; i++) {
      final angle = i * angleStep - math.pi / 2;
      final length = i.isEven ? radius : radius * 0.4;
      final x = center.dx + length * math.cos(angle);
      final y = center.dy + length * math.sin(angle);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    
    path.close();
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

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

class _LessonResultScreenState extends State<LessonResultScreen>
    with TickerProviderStateMixin {
  // Static flag to track initialization across all instances
  static bool _hasInitialized = false;
  
  late AnimationController _animationController;
  late AnimationController _progressController;
  late AnimationController _bounceController;
  late AnimationController _rotateController;
  late AnimationController _shakeController;
  late AnimationController _jumpController;
  late AnimationController _sparkleController;
  late AnimationController _floatingObjectsController;
  
  // For particle effects
  List<ParticleModel> particles = [];
  List<Color> particleColors = [];
  Timer? _particleTimer;
  Timer? _characterAnimationTimer;
  
  int _characterAnimState = 0;
  bool _showSuccess = false;
  
  @override
  void initState() {
    super.initState();

    // Setup animation controllers
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000),
    );
    
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _jumpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    
    _floatingObjectsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8000),
    );
    
    // Generate particle colors based on performance - safe to do in initState
    _initParticleColors();
    
    // Use a post-frame callback to safely start animations after the first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      
      // Start repeat animations
      _bounceController.repeat(reverse: true);
      _rotateController.repeat();
      _sparkleController.repeat();
      _floatingObjectsController.repeat(reverse: true);
      
      // Start one-time animations
      _animationController.forward();
      _progressController.forward();
      
      // Initialize particles and animations
      final screenSize = MediaQuery.of(context).size;
      _initParticlesAfterBuild(screenSize.width);
      _startParticleAnimationAfterBuild(screenSize.width, screenSize.height);
      _startCharacterAnimationAfterBuild();
    });
    
    // Show success animation after progress completes
    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.isPerfect && mounted) {
        // Use post-frame callback to safely update state
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          setState(() {
            _showSuccess = true;
          });
          
          // Trigger a small shake
          Future.microtask(() {
            if (mounted) {
              _shakeController.forward().then((_) {
                if (mounted) _shakeController.reset();
              });
            }
          });
        });
      }
    });
  }
  
  void _initParticleColors() {
    final percentage = (widget.correctAnswers / widget.totalQuestions * 100).toInt();
    
    if (widget.isPerfect) {
      particleColors = [
        Colors.amber,
        Colors.amberAccent,
        Colors.yellow,
        Colors.orange,
        Colors.pinkAccent,
        AppColors.primary,
      ];
    } else if (percentage >= 70) {
      particleColors = [
        AppColors.accent,
        Colors.greenAccent,
        Colors.lightBlueAccent,
        AppColors.primary,
        Colors.tealAccent,
      ];
    } else {
      particleColors = [
        AppColors.secondary,
        Colors.purpleAccent,
        AppColors.primary,
        Colors.pinkAccent,
      ];
    }
  }
  
  void _initParticles() {
    // Don't initialize particles in initState since MediaQuery isn't available yet
    // This will be called later in the first build via a post-frame callback
  }
  
  void _initParticlesAfterBuild(double screenWidth) {
    if (particles.isNotEmpty) return; // Skip if already initialized
    
    final rnd = math.Random();
    
    // Create floating particles
    for (int i = 0; i < 20; i++) {
      particles.add(
        ParticleModel(
          id: i,
          x: rnd.nextDouble() * screenWidth,
          y: rnd.nextDouble() * 700,
          size: rnd.nextDouble() * 15 + 5,
          color: particleColors[rnd.nextInt(particleColors.length)],
          shape: rnd.nextInt(3), // 0: circle, 1: square, 2: triangle
          speedX: (rnd.nextDouble() * 2 - 1) * 0.5,
          speedY: (rnd.nextDouble() * 2 - 1) * 0.5,
          opacity: rnd.nextDouble() * 0.6 + 0.2,
        ),
      );
    }
  }
  
  void _startParticleAnimation() {
    // We'll start the animation in the first build
  }
  
  void _startParticleAnimationAfterBuild(double screenWidth, double screenHeight) {
    if (_particleTimer != null) return; // Skip if already started
    
    _particleTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      final rnd = math.Random();
      
      if (mounted) {
        setState(() {
          for (var particle in particles) {
            // Update position
            particle.x += particle.speedX;
            particle.y += particle.speedY;
            
            // Bounce off edges
            if (particle.x < 0 || particle.x > screenWidth) {
              particle.speedX *= -1;
            }
            
            if (particle.y < 0 || particle.y > screenHeight) {
              particle.speedY *= -1;
            }
            
            // Randomly change opacity
            if (rnd.nextDouble() < 0.02) {
              particle.opacity = rnd.nextDouble() * 0.6 + 0.2;
            }
          }
        });
      }
    });
  }
  
  void _startCharacterAnimation() {
    // Placeholder - will be called in post-frame callback
  }
  
  void _startCharacterAnimationAfterBuild() {
    if (_characterAnimationTimer != null) return; // Skip if already started
    
    // Only animate if we're doing well
    if (!widget.isPerfect && (widget.correctAnswers / widget.totalQuestions * 100) < 70) {
      return;
    }
    
    _characterAnimationTimer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      if (mounted) {
        setState(() {
          _characterAnimState = (_characterAnimState + 1) % 3;
        });
        
        // Jump animation
        _jumpController.reset();
        _jumpController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _progressController.dispose();
    _bounceController.dispose();
    _rotateController.dispose();
    _shakeController.dispose();
    _jumpController.dispose();
    _sparkleController.dispose();
    _floatingObjectsController.dispose();
    _particleTimer?.cancel();
    _characterAnimationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final percentage = (widget.correctAnswers / widget.totalQuestions * 100).toInt();
    
    // Define colors based on the app's color scheme
    final Color primaryColor = widget.isPerfect 
        ? AppColors.primary  // Use app's primary color for perfect score
        : (percentage >= 70 ? AppColors.accent : AppColors.secondary);
    
    final String resultMessage = widget.isPerfect
        ? "Perfect lesson!"
        : (percentage >= 70 ? "Great job!" : "Keep practicing!");
        
    return Scaffold(
      backgroundColor: Colors.white, // Clean white background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Decorative background elements
            ..._buildBackgroundElements(),
            
            // Confetti for perfect score
            if (widget.isPerfect) _buildConfetti(),
            
            // Animated floating particles
            ..._buildParticles(),
            
            // Animated floating objects (kid-friendly)
            ..._buildFloatingObjects(primaryColor),
            
            // Success animation on completion
            if (_showSuccess)
              Center(
                child: Lottie.asset(
                  LottieAssets.confetti,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            
            // Main content
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const Gap(AppSizes.xl),
                      
                      // Trophy or result badge
                      AnimatedBuilder(
                        animation: _shakeController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                              math.sin(_shakeController.value * math.pi * 4) * 10, 
                              0
                            ),
                            child: child,
                          );
                        },
                        child: AnimatedBuilder(
                          animation: _jumpController,
                          builder: (context, child) {
                            double jumpValue = 0;
                            
                            // Custom jump curve
                            if (_jumpController.value < 0.5) {
                              jumpValue = -Curves.easeOut.transform(_jumpController.value * 2) * 20;
                            } else {
                              jumpValue = -Curves.elasticIn.transform((_jumpController.value - 0.5) * 2) * 20;
                            }
                            
                            return Transform.translate(
                              offset: Offset(0, jumpValue),
                              child: child,
                            );
                          },
                          child: _buildResultBadge(screenSize, primaryColor, percentage),
                        ),
                      ),
                      
                      const Gap(AppSizes.xl),
                      
                      // Result message with clean styling
                      if (widget.isPerfect)
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primaryDeep, 
                                AppColors.primary
                              ],
                              stops: const [0.0, 0.5, 1.0],
                              tileMode: TileMode.clamp,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds);
                          },
                          child: Text(
                            resultMessage,
                            style: TextStyle(
                              fontFamily: 'Bricolage Grotesque',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Will be replaced by shader
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 2),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          )
                          .animate(controller: _animationController)
                          .slide(begin: const Offset(0, 0.2), duration: const Duration(milliseconds: 800), curve: Curves.easeOutQuad)
                          .fadeIn(duration: const Duration(milliseconds: 800)),
                        )
                      else
                        // Regular text for non-perfect scores
                        Text(
                          resultMessage,
                          style: TextStyle(
                            fontFamily: 'Bricolage Grotesque',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                            shadows: [
                              Shadow(
                                color: primaryColor.withOpacity(0.1),
                                offset: const Offset(0, 2),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      
                      const Gap(AppSizes.md),
                      
                      // Submessage
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Text(
                          widget.customMessage ??
                              (widget.isPerfect
                                  ? "You made no mistakes in this lesson! Keep it up!"
                                  : "You got ${widget.correctAnswers} out of ${widget.totalQuestions} correct"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Bricolage Grotesque',
                            fontSize: 16,
                            color: AppColors.textPrimary,
                            height: 1.3,
                          ),
                        ),
                      ),
                      
                      const Gap(AppSizes.xl),
                      
                      // Progress bar with sparkles
                      Stack(
                        children: [
                          _buildProgressBar(percentage, primaryColor),
                          
                          // Add sparkles along the progress bar for high scores
                          if (percentage >= 70) ..._buildProgressSparkles(percentage, primaryColor),
                        ],
                      ),
                      
                      const Gap(AppSizes.xl),
                      
                      // Stats cards with bounce effects
                      _buildStatsCards(screenSize, primaryColor, percentage),
                      
                      const Gap(AppSizes.xl),
                      
                      // Continue button with glowing effect and pulse
                      _buildEnhancedContinueButton(primaryColor),
                      
                      const Gap(AppSizes.xl),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  List<Widget> _buildBackgroundElements() {
    final screenSize = MediaQuery.of(context).size;
    
    return [
      // Top right decorative element - subtle curved shape
      Positioned(
        top: -20,
        right: -40,
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withOpacity(0.15),
            borderRadius: BorderRadius.circular(90),
          ),
        ),
      ),
      
      // Top left accent dot
      Positioned(
        top: 60,
        left: 30,
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.7),
            shape: BoxShape.circle,
          ),
        ),
      ),
      
      // Simple horizontal accent line at the top
      Positioned(
        top: 50,
        left: 45,
        child: Container(
          width: screenSize.width * 0.2,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.6),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      
      // Bottom left decorative element - subtle curved shape
      Positioned(
        bottom: -30,
        left: -30,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(75),
          ),
        ),
      ),
      
      // Bottom right small accent circle
      Positioned(
        bottom: 40,
        right: 30,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
        ),
      ),
    ];
  }
  
  List<Widget> _generateStars(int count) {
    final List<Widget> stars = [];
    final rnd = math.Random();
    
    for (int i = 0; i < count; i++) {
      final size = rnd.nextDouble() * 6 + 2; // star size between 2-8
      final top = rnd.nextDouble() * MediaQuery.of(context).size.height;
      final left = rnd.nextDouble() * MediaQuery.of(context).size.width;
      final opacity = rnd.nextDouble() * 0.8 + 0.2; // opacity between 0.2-1.0
      final delay = Duration(milliseconds: rnd.nextInt(2000));
      
      // Create either a circle star or an actual star shape
      Widget starWidget;
      if (rnd.nextBool()) {
        // Circle star
        starWidget = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(opacity * 0.5),
                blurRadius: size * 2,
                spreadRadius: size / 2,
              ),
            ],
          ),
        );
      } else {
        // Actual star shape
        starWidget = CustomPaint(
          size: Size(size * 1.5, size * 1.5),
          painter: StarPainter(
            color: Colors.white.withOpacity(opacity),
          ),
        );
      }
      
      stars.add(
        Positioned(
          top: top,
          left: left,
          child: starWidget,
        ),
      );
    }
    
    return stars;
  }
  
  // Animate particles on the screen
  List<Widget> _buildParticles() {
    final widgets = <Widget>[];
    
    // Return an empty list if particles aren't initialized yet
    // This prevents issues during the initial build
    if (particles.isEmpty) {
      return widgets;
    }
    
    for (var p in particles) {
      Widget particleWidget;
      
      switch (p.shape) {
        case 0: // Circle
          particleWidget = Container(
            width: p.size,
            height: p.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: p.color.withOpacity(p.opacity),
              boxShadow: [
                BoxShadow(
                  color: p.color.withOpacity(p.opacity * 0.5),
                  blurRadius: p.size / 2,
                ),
              ],
            ),
          );
          break;
          
        case 1: // Square
          particleWidget = Container(
            width: p.size,
            height: p.size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(p.size * 0.2),
              color: p.color.withOpacity(p.opacity),
              boxShadow: [
                BoxShadow(
                  color: p.color.withOpacity(p.opacity * 0.5),
                  blurRadius: p.size / 2,
                ),
              ],
            ),
          );
          break;
          
        case 2: // Star
        default:
          particleWidget = CustomPaint(
            size: Size(p.size, p.size),
            painter: StarPainter(
              color: p.color.withOpacity(p.opacity),
            ),
          );
          break;
      }
      
      widgets.add(
        Positioned(
          left: p.x,
          top: p.y,
          child: particleWidget,
        ),
      );
    }
    
    return widgets;
  }
  
  // Kid-friendly floating objects (like happy emojis, stars, etc)
  List<Widget> _buildFloatingObjects(Color primaryColor) {
    // We'll limit the number of floating objects to reduce computational load
    // and do it only for good/perfect scores
    if (!widget.isPerfect && widget.correctAnswers / widget.totalQuestions < 0.7) {
      return []; // No floating objects for lower scores
    }
    
    // Create up to 3 objects maximum to prevent overload
    final maxObjects = widget.isPerfect ? 3 : 2;
    final List<Widget> objects = [];
    final rnd = math.Random();
    
    // Use safe access to screen dimensions with reasonable defaults
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height * 0.8; // Use only 80% of height
    
    // Create floating icon objects
    List<IconData> icons = [
      Icons.star_rounded,
      Icons.favorite_rounded,
      Icons.celebration_rounded,
      Icons.emoji_emotions_rounded,
    ];
    
    for (int i = 0; i < maxObjects; i++) {
      // Place objects in a more limited area to avoid overflow
      final x = 20.0 + rnd.nextDouble() * (screenWidth - 40.0); // Stay 20px from edges
      final y = 100.0 + rnd.nextDouble() * (screenHeight - 200.0); // Stay away from top/bottom
      
      final size = rnd.nextDouble() * 10 + 15; // Size between 15-25
      final rotSpeed = rnd.nextDouble() * 1.5 - 0.75; // Slower rotation
      final delay = rnd.nextDouble();
      final iconIndex = rnd.nextInt(icons.length);
      
      // Pick colors based on score
      Color iconColor;
      if (widget.isPerfect) {
        // App's brand colors for perfect score
        iconColor = [
          AppColors.primary,
          AppColors.primaryDeep,
          AppColors.primaryLight,
        ][rnd.nextInt(3)];
      } else {
        // Regular accent colors for good score
        iconColor = [
          primaryColor,
          AppColors.accent,
          AppColors.primary,
        ][rnd.nextInt(3)];
      }
      
      objects.add(
        Positioned(
          left: x,
          top: y,
          child: AnimatedBuilder(
            animation: _floatingObjectsController,
            builder: (context, child) {
              // Create a floating animation using sine curves
              final floatValue = math.sin(
                (_floatingObjectsController.value * 2 * math.pi) + (delay * 2 * math.pi)
              ) * 10; // Reduce float distance
              
              return Transform.translate(
                offset: Offset(0, floatValue),
                child: Transform.rotate(
                  angle: _floatingObjectsController.value * rotSpeed * 2 * math.pi,
                  child: Icon(
                    icons[iconIndex],
                    color: iconColor,
                    size: size,
                    shadows: [
                      Shadow(
                        color: iconColor.withOpacity(0.5),
                        blurRadius: 5,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
    
    return objects;
  }
  
  // Add sparkles to the progress bar for high scores
  List<Widget> _buildProgressSparkles(int percentage, Color primaryColor) {
    final List<Widget> sparkles = [];
    
    // Don't try to add sparkles if the animation controller isn't ready
    if (!_sparkleController.isAnimating) {
      return sparkles;
    }
    
    // Calculate progress bar width safely
    final progressWidth = math.max(0, MediaQuery.of(context).size.width - 40); // Account for padding
    final progressValue = _progressController.value;
    
    // Limit number of sparkles to reduce load
    final sparkleCount = widget.isPerfect ? 3 : 2;
    
    for (int i = 0; i < sparkleCount; i++) {
      // Distribute sparkles along the progress (safely)
      final position = (progressWidth * percentage / 100 * progressValue) * (i + 1) / (sparkleCount + 1);
      
      // Skip invalid positions
      if (position <= 0 || position >= progressWidth) continue;
      
      sparkles.add(
        Positioned(
          left: position,
          top: 6, // Position at the middle of progress bar
          child: SparkleWidget(
            size: 8, 
            color: widget.isPerfect ? AppColors.primary : primaryColor,
            animation: _sparkleController,
          ),
        ),
      );
    }
    
    return sparkles;
  }
  
  Widget _buildResultBadge(Size screenSize, Color primaryColor, int percentage) {
    // Choose the appropriate mascot based on the result
    final String mascotImage = widget.isPerfect 
        ? ImageAssets.happy_owl
        : (percentage >= 70 ? ImageAssets.happy_owl : ImageAssets.sad_owl);
    
    return AnimatedBuilder(
      animation: _bounceController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounceController.value * 4 - 2),
          child: child,
        );
      },
      child: Container(
        width: screenSize.width * 0.5,
        height: screenSize.width * 0.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.15),
              blurRadius: 15,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Subtle background circle
              Container(
                width: screenSize.width * 0.46,
                height: screenSize.width * 0.46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.08),
                ),
              ),
              
              // Character image
              Image.asset(
                mascotImage,
                width: screenSize.width * 0.38,
                height: screenSize.width * 0.38,
                fit: BoxFit.contain,
              ),
              
              // Stars around perfect score
              if (widget.isPerfect) ...[                    
                for (int i = 0; i < 5; i++)
                  Positioned(
                    left: screenSize.width * 0.25 + math.cos(i * 2 * math.pi / 5) * screenSize.width * 0.2,
                    top: screenSize.width * 0.25 + math.sin(i * 2 * math.pi / 5) * screenSize.width * 0.2,
                    child: SparkleWidget(
                      size: 16,
                      color: AppColors.primary,
                      animation: _sparkleController,
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildProgressBar(int percentage, Color primaryColor) {
    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.equalizer_rounded,
                        color: AppColors.textPrimary,
                        size: 16,
                      ),
                      const Gap(AppSizes.xs),
                      Text(
                        "Progress",
                        style: TextStyle(
                          fontFamily: 'Bricolage Grotesque',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  AnimatedBuilder(
                    animation: _bounceController,
                    builder: (context, child) {
                      // Add a little bounce to the percentage text when it reaches 100%
                      final scale = widget.isPerfect && 
                                   percentage * _progressController.value >= 99.9 ? 
                                   1.0 + _bounceController.value * 0.2 : 1.0;
                      
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Text(
                      "${(percentage * _progressController.value).toInt()}%",
                      style: TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(AppSizes.sm),
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  children: [
                    // Progress background
                    Container(
                      width: double.infinity,
                      height: 12,
                      color: Colors.transparent,
                    ),
                    // Animated progress fill with gradient
                    Stack(
                      children: [
                        // Progress fill
                        Container(
                          width: math.max(0, math.min((MediaQuery.of(context).size.width - 40) * 
                              percentage / 100 * 
                              _progressController.value, MediaQuery.of(context).size.width - 52)), // Ensure width is constrained
                          height: 12,
                          decoration: BoxDecoration(
                            color: primaryColor,
                          ),
                          // Add a small animated shine effect on the progress bar
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment(-1.0 + _bounceController.value * 2, 0.0),
                                end: Alignment(-0.5 + _bounceController.value * 2, 0.0),
                                colors: [
                                  Colors.white.withOpacity(0.0),
                                  Colors.white.withOpacity(0.2),
                                  Colors.white.withOpacity(0.0),
                                ],
                                stops: const [0.0, 0.5, 1.0],
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.srcIn,
                            child: Container(color: Colors.white),
                          ),
                        ),
                        
                        // Progress knob
                        Positioned(
                          left: math.max(0, math.min((MediaQuery.of(context).size.width - 40) * 
                              percentage / 100 * 
                              _progressController.value - 6, MediaQuery.of(context).size.width - 58)),
                          top: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: _progressController.value >= 0.99 ?
                              Center(
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 8,
                                ),
                              ) : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  
  Widget _buildStatsCards(Size screenSize, Color primaryColor, int percentage) {
    return Row(
      children: [
        // XP Card
        Expanded(
          child: _buildStatCard(
            "XP EARNED",
            "+${widget.totalXp}",
            AppColors.primary,
            Icons.star_rounded,
            screenSize,
            delay: 100,
            showSpecialEffect: widget.totalXp >= 50,
          ),
        ),
        const Gap(AppSizes.md),
        // Score Card
        Expanded(
          child: _buildStatCard(
            "CORRECT",
            "${widget.correctAnswers}/${widget.totalQuestions}",
            percentage >= 70 ? AppColors.succuss : AppColors.secondary,
            percentage >= 70 ? Icons.check_circle_rounded : Icons.info_rounded,
            screenSize,
            delay: 200,
            showSpecialEffect: percentage >= 70,
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatCard(
    String title,
    String value,
    Color color,
    IconData icon,
    Size screenSize, {
    int delay = 0,
    bool showSpecialEffect = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Special animated icon for good scores
              if (showSpecialEffect)
                AnimatedBuilder(
                  animation: _bounceController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _bounceController.value * 0.2 - 0.1,
                      child: child,
                    );
                  },
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                )
              else
                Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              const Gap(AppSizes.xs),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Bricolage Grotesque',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const Gap(AppSizes.sm),
          // Special animated value for good scores
          if (showSpecialEffect)
            AnimatedBuilder(
              animation: _bounceController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + _bounceController.value * 0.1,
                  child: child,
                );
              },
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: 'Bricolage Grotesque',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            )
          else
            Text(
              value,
              style: TextStyle(
                fontFamily: 'Bricolage Grotesque',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
        ],
      ),
    );
  }
  
  // Enhanced continue button with clean animations
  Widget _buildEnhancedContinueButton(Color primaryColor) {
    return AnimatedBuilder(
      animation: _bounceController,
      builder: (context, child) {
        return Container(
          width: 220,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: primaryColor,
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.2 + _bounceController.value * 0.1),
                blurRadius: 10 + _bounceController.value * 5,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Trigger a shake animation when pressed
                _shakeController.forward().then((_) => _shakeController.reset());
                
                // Call the continue callback
                widget.onContinue();
              },
              borderRadius: BorderRadius.circular(28),
              splashColor: Colors.white.withOpacity(0.2),
              highlightColor: Colors.transparent,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Subtle shine animation across the button
                  Positioned.fill(
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment(-1.0 + _bounceController.value * 2, 0.0),
                          end: Alignment(-0.5 + _bounceController.value * 2, 0.0),
                          colors: [
                            Colors.white.withOpacity(0.0),
                            Colors.white.withOpacity(0.2),
                            Colors.white.withOpacity(0.0),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.srcIn,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                    ),
                  ),
                  
                  // Button text and icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "CONTINUE",
                        style: TextStyle(
                          fontFamily: 'Bricolage Grotesque',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                      const Gap(AppSizes.sm),
                      // Animated arrow
                      Transform.translate(
                        offset: Offset(_bounceController.value * 2, 0),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildConfetti() {
    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: _animationController.value,
        duration: const Duration(milliseconds: 500),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Lottie.asset(
            LottieAssets.confetti,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}