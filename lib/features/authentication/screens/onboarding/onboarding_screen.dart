import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:kids_learning_app/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:kids_learning_app/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:kids_learning_app/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:kids_learning_app/features/authentication/screens/onboarding/widgets/onboarding_previous_button.dart';
import 'package:kids_learning_app/features/authentication/screens/welcome/widgets/logo_header.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/text_strings.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          //* horizontal scrollable pages
          LogoHeader(),
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                illustration: ImageAssets.onBoarding1,
                title: CustomTexts.onBoardingTitle1,
                subtitle: CustomTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                illustration: ImageAssets.onBoarding2,
                title: CustomTexts.onBoardingTitle2,
                subtitle: CustomTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                illustration: ImageAssets.onBoarding3,
                title: CustomTexts.onBoardingTitle3,
                subtitle: CustomTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          //* skip button
          //const OnBoardingSkip(),

          //* dot navigator smoothPageIndicator
          const OnBoardingDotNavigation(),

          //* circular button
          const OnBoardingNextButton(),
          const OnBoardingPreviousButton(),
        ],
      ),
    );
  }
}
