import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:kids_learning_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:kids_learning_app/features/home/screens/home_sceen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //* variables
  final deviceStorage = GetStorage();
  @override
  void onReady() {
    screenRedirect(); //? redirect to the appropriate screen
  }

  //* function to show relevant screen
  void screenRedirect() async {
    Get.to(() => const HomeScreen());
  }
}
