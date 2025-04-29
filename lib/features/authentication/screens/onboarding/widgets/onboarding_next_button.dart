import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kids_learning_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';
import 'package:kids_learning_app/utils/device/device_utility.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: AppSizes.defaultSpace,
      bottom: DeviceUtils.getBottomNavigationBarHeight(),
      child: IconButton(
        icon: const Icon(Iconsax.arrow_right_1, color: AppColors.buttonPrimary),
        onPressed: () => OnBoardingController.instance.nextPage(),
      ),
    );
  }
}
