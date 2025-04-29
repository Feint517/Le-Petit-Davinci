import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/device/device_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      bottom: DeviceUtils.getBottomNavigationBarHeight() + 25,
      left: DeviceUtils.getScreenWidth(context) / 2 - 50,

      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(
          activeDotColor: AppColors.primary,
          dotColor: AppColors.primary.withValues(alpha: 0.3),
          dotHeight: 6,
        ),
      ),
    );
  }
}
