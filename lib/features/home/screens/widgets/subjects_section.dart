import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/show_all_button.dart';
import 'package:kids_learning_app/features/home/controllers/home_controller.dart';
import 'package:kids_learning_app/features/home/screens/widgets/subject_card.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class SubjectsSection extends GetView<HomeController> {
  const SubjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Sélection des matières",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'BricolageGrotesque',
              ),
            ),
            //ShowAllButton(callback: () {}),
          ],
        ),
        const Gap(AppSizes.spaceBtwItems),
        SizedBox(
          height: 220,
          child: Obx(
            () => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeController.subjects.length,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 4),
              itemBuilder: (context, index) {
                final subject = homeController.subjects[index];
                return SubjectCard(
                  title: subject['title']! as String,
                  total: subject['total'] as String,
                  imagePath: subject['image'] as String,
                  progress: subject['progress'] as double,
                  onTap: subject['onTap'] as VoidCallback,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
