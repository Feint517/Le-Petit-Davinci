import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/common/widgets/show_all_button.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/subject_deatils/widgets/progress_row.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class DetailIntroductionScreen extends StatelessWidget {
  const DetailIntroductionScreen({
    super.key,
    required this.title,
    required this.illustrationPath,
    required this.introductionTitle,
    required this.totalLessons,
    required this.completedLessons,
    required this.lessonCards,
  });

  final String title;
  final String illustrationPath;
  final String introductionTitle;
  final int totalLessons;
  final int completedLessons;
  final List<Widget> lessonCards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
                child: Column(
                  children: [
                    //* Header and Illustration
                    CommonHeader(
                      pageTitle: title,
                      trailing: CircleAvatar(
                        backgroundImage: AssetImage(IconAssets.avatar),
                        radius: 24,
                      ),
                    ),
                    const Gap(AppSizes.defaultSpace),
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
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.2),
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: Offset(
                        0,
                        -3,
                      ), // shadow appears above (only top left/right)
                    ),
                  ],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
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
                        ShowAllButton(
                          callback: () {
                            // Navigation code here
                          },
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
