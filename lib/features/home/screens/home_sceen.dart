import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/custom_app_bar.dart';
import 'package:kids_learning_app/features/home/controllers/home_controller.dart';
import 'package:kids_learning_app/features/home/screens/widgets/games_section.dart';
import 'package:kids_learning_app/features/home/screens/widgets/primary_section.dart';
import 'package:kids_learning_app/features/home/screens/widgets/subjects_section.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final String selectedSubject = 'Français';

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Profile and Progress
              CustomAppBar(),
              const Gap(24),

              //* Welcome Text
              PrimarySection(),
              const Gap(AppSizes.spaceBtwSections),

              //* Matières
              SubjectsSection(),
              const Gap(AppSizes.spaceBtwSections),

              //* Jeux éducatifs
              const GamesSection(),
              const Gap(AppSizes.spaceBtwSections),

              //* Matériaux
              //const MaterialsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
