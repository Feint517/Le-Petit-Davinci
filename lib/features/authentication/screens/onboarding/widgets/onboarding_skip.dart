import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:kids_learning_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';
import 'package:kids_learning_app/utils/device/device_utility.dart';

class OnBoardingSkip extends GetView<OnBoardingController> {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: DeviceUtils.getAppBarHeight(),
      right: AppSizes.defaultSpace,
      child: TextButton(
        onPressed: () => controller.skipPage(),
        child: const Text("Skip"),
      ),
    );
  }
}