import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kids_learning_app/features/authentication/screens/welcome/welcome_screen.dart';

class OnBoardingController extends GetxController {
  //static OnBoardingController get instance => Get.find();

  //? variables
  final pageController = PageController(); 
  Rx<int> currentPageIndex = 0.obs;   //! means "observer", listens to the stream and change the disign without stfl widgets
  

  //? update current index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  //? jump to the new specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value =
        index; //! because it's of type Rx<int> we have to put .value
    pageController.jumpTo(index);
  }

  //? update current index and jump to next page
  void nextPage() {
    //! change the value depending on how many pages we do have
    if (currentPageIndex.value == 2) {
      // Ne pas mettre à jour le statut isFirstTime pour qu'il reste vrai
      // et que l'onboarding s'affiche à chaque fois
      if (kDebugMode) {
        print("================ Get Storage NEXT BUTTON ================");
        print("Redirection vers WelcomeScreen sans mettre à jour isFirstTime");
      }

      //?  Using a widget function instead of a widget fully guarantees that the widget and its controllers will be removed from memory when they are no longer used.
      Get.offAll(() => const WelcomeScreen());

    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  //? update current index and jump to last page
  void skipPage() {
    currentPageIndex.value = 2; //! values start from 0, 1, 2....
    pageController.jumpToPage(2);
  }
}
