import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/profile_header.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/progress_row.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class DetailIntroductionScreen extends StatelessWidget {
  const DetailIntroductionScreen({
    super.key,
    required this.illustrationPath,
    required this.introductionTitle,
    required this.totalLessons,
    required this.completedLessons,
    required this.lessonCards,
  });

  final String illustrationPath;
  final String introductionTitle;
  final int totalLessons;
  final int completedLessons;
  final List<Widget> lessonCards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
                child: Column(
                  children: [
                    //* Header and Illustration
                    ProfileHeader(activeIcon: false),
                    SizedBox(
                      child: Image.asset(
                        illustrationPath,
                        height: MediaQuery.of(context).size.height / 3,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),

              //* Main content
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //* Title Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          introductionTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDeep,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Voir tout",
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(AppSizes.defaultSpace),

                    ProgressRow(
                      finishedLessons: completedLessons,
                      totalLessons: totalLessons,
                    ),
                    const Gap(AppSizes.defaultSpace),

                    //* Lesson Cards
                    ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: [...lessonCards],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
