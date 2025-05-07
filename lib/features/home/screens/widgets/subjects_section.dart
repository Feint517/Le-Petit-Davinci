import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/show_all_button.dart';
import 'package:kids_learning_app/features/home/screens/widgets/subject_card.dart';
import 'package:kids_learning_app/features/subject_deatils/subject_deatils_screen.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class SubjectsSection extends StatelessWidget {
  SubjectsSection({super.key});

  final subjects = [
    {
      "title": "Mathématiques",
      "total": "15 matériaux au total",
      "image": SvgAssets.math_icon,
      "progress": 0.8,
      "color": Color(0xFFBBA1FF),
      "onTap": () {},
    },
    {
      "title": "Français",
      "total": "10 matériaux au total",
      "image": SvgAssets.abc,
      "progress": 0.5,
      "color": Color(0xFFFFA7EC),
      "onTap": () => Get.to(() => const SubjectDetailScreen()),
    },
    {
      "title": "Anglais",
      "total": "10 matériaux au total",
      "image": SvgAssets.abc,
      "progress": 0.3,
      "color": Color(0xFFFFB89E),
      "onTap": () {},
    },
  ];

  @override
  Widget build(BuildContext context) {
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
            ShowAllButton(callback: () {}),
          ],
        ),
        const Gap(AppSizes.spaceBtwItems),
        SizedBox(
          height: 220, // Increased height to accommodate the enhanced card
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: subjects.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 4),
            itemBuilder: (context, index) {
              final subject = subjects[index];
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
      ],
    );
  }
}