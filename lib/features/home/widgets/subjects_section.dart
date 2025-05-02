import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/show_all_button.dart';
import 'package:kids_learning_app/features/home/widgets/subject_card.dart';
import 'package:kids_learning_app/features/subject_deatils/subject_deatils_screen.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class SubjectsSection extends StatelessWidget {
  SubjectsSection({super.key});

  final subjects = [
    {
      "title": "Mathématiques",
      "total": "15 matériaux au total",
      "image": SvgAssets.abc,
      "progress": 0.7,
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
            Text(
              "Sélection des matières",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            ShowAllButton(callback: () {}),
          ],
        ),
        const Gap(AppSizes.spaceBtwItems),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: AppSizes.md),
                    child: SubjectCard(
                      title: subject['title']! as String,
                      total: subject['total'] as String,
                      imagePath: subject['image'] as String,
                      progress: subject['progress'] as double,
                      onTap: subject['onTap'] as VoidCallback,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
