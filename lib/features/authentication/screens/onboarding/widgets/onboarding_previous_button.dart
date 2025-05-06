import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kids_learning_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';
import 'package:kids_learning_app/utils/device/device_utility.dart';

class OnBoardingPreviousButton extends GetView  <OnBoardingController> {
  const OnBoardingPreviousButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: AppSizes.defaultSpace,
      bottom: DeviceUtils.getBottomNavigationBarHeight(),
      child: IconButton(
        icon: const Icon(Iconsax.arrow_left, color: AppColors.buttonPrimary),
        onPressed: () => controller.nextPage(),
      ),
    );
  }
}
