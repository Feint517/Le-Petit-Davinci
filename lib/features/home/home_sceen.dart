import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/common/widgets/custom_app_bar.dart';
import 'package:kids_learning_app/features/home/widgets/games_section.dart';
import 'package:kids_learning_app/features/home/widgets/primary_section.dart';
import 'package:kids_learning_app/features/home/widgets/subjects_section.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ChildHomeScreen extends StatelessWidget {
  const ChildHomeScreen({super.key});

  final String selectedSubject = 'Français';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Profile and Progress
              CustomAppBar(),
              const Gap(24),

              //* Welcome Text
              PrimarySection(),
              const Gap(24),

              //* Matières
              SubjectsSection(),
              const Gap(25),

              //* Jeux éducatifs
              const GamesSection(),
              const Gap(30),

              //* Matériaux
              //const MaterialsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
