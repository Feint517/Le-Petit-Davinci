import 'package:get/get.dart';
import 'package:kids_learning_app/features/subject_deatils/subject_deatils_screen.dart';
import 'package:kids_learning_app/features/subject_deatils/math_details_screen.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class HomeController extends GetxController {
  //* Subjects data as an observable list
  final subjects = [
    {
      "title": "Mathématiques",
      "total": "15 matériaux au total",
      "image": IconAssets.math,
      "progress": 0.7,
      "onTap": () {
        Get.to(() => const MathDetailScreen());
      },
    },
    {
      "title": "Français",
      "total": "10 matériaux au total",
      "image": IconAssets.abc,
      "progress": 0.5,
      "onTap": (){
        Get.to(() => const SubjectDetailScreen());
      }
    },
    {
      "title": "Anglais",
      "total": "10 matériaux au total",
      "image": IconAssets.abc,
      "progress": 0.3,
      "onTap": () {},
    },
  ].obs;
}