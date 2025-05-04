import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kids_learning_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:kids_learning_app/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // Animation controllers for different phases
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _zoomOutController;
  late AnimationController _fadeController;
  
  // Animation values
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _zoomOutAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    if (kDebugMode) {
      print("Splash Screen initialized");
    }
    
    // Slide controller
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    // Scale controller
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // Zoom out controller (quick)
    _zoomOutController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    // Fade controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Slide animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Scale animation (zoom in)
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    // Zoom out animation (logo shrinks to 0)
    _zoomOutAnimation = Tween<double>(
      begin: 1.2,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _zoomOutController,
      curve: Curves.easeIn,
    ));

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
    
    // Make sure to start animation sequence after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playAnimationSequence();
    });
  }

  Future<void> _playAnimationSequence() async {
    try {
      if (kDebugMode) {
        print("Starting animation sequence");
      }
      
      // Short delay
      await Future.delayed(const Duration(milliseconds: 300));
      
      // Slide in
      await _slideController.forward();
      
      // Scale (zoom in)
      await _scaleController.forward();
      
      // Hold a bit
      await Future.delayed(const Duration(milliseconds: 600));
      
      // Zoom out quickly
      await _zoomOutController.forward();
      
      // Fade out (optional, but keep for smoothness)
      await _fadeController.forward();
      
      // Check if it's the first time launching the app
      final storage = GetStorage();
      final isFirstTime = storage.read('isFirstTime') ?? true;
      
      if (kDebugMode) {
        print("isFirstTime: $isFirstTime");
      }
      
      // Navigate to the appropriate screen
      if (isFirstTime) {
        Get.offAll(() => const OnBoardingScreen(), transition: Transition.fade);
      } else {
        Get.offAll(() => const WelcomeScreen(), transition: Transition.fade);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in animation sequence: $e");
      }
      // Fallback navigation in case of error
      Get.offAll(() => const OnBoardingScreen());
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    _zoomOutController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _slideController, 
          _scaleController,
          _zoomOutController,
          _fadeController,
        ]),
        builder: (context, child) {
          final opacity = _fadeController.isAnimating
              ? _fadeAnimation.value.clamp(0.0, 1.0)
              : 1.0;
          // Use zoomOut if it's running, otherwise use scale
          double scale;
          if (_zoomOutController.isAnimating || _zoomOutController.isCompleted) {
            // Clamp to a minimum value to ensure the logo shrinks to nearly invisible
            scale = _zoomOutAnimation.value.clamp(0.01, 1.2);
          } else {
            scale = _scaleAnimation.value;
          }
          return Center(
            child: SlideTransition(
              position: _slideAnimation,
              child: Opacity(
                opacity: opacity,
                child: Transform.scale(
                  scale: scale,
                  child: Image.asset(
                    'assets/images/illustrations/splash.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}