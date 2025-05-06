import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/splash/controller/splash_controller.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedBuilder(
        //* Listen to all animation controllers
        animation: Listenable.merge([
          controller.slideController, 
          controller.scaleController,
          controller.zoomOutController,
          controller.fadeController,
        ]),
        builder: (context, child) {
          //* Get current opacity and scale from controller
          final opacity = controller.getCurrentOpacity();
          final scale = controller.getCurrentScale();
          
          return Center(
            child: SlideTransition(
              position: controller.slideAnimation,
              child: Opacity(
                opacity: opacity,
                child: Transform.scale(
                  scale: scale,
                  child: Image.asset(
                    ImageAssets.splashLogo,
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