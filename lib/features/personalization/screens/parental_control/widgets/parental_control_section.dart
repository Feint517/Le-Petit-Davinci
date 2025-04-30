import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/features/personalization/screens/parental_control/widgets/parental_control_option.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ParentalControlSection extends StatelessWidget {
  const ParentalControlSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, //? Ensure full width
      children: [
        ParentalControlOption(
          title: "Limites de temps",
          description: "Définir des limites quotidiennes d'utilisation",
          titleColor: AppColors.primaryDeep,
        ),
        Gap(12),
        ParentalControlOption(
          title: "Contenu accessible",
          description: "Gérer l'accès aux sujets et jeux",
          titleColor: AppColors.secondary,
        ),
      ],
    );
  }
}
