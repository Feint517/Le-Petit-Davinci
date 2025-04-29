import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/features/home/widgets/material_card.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class MaterialsSection extends StatelessWidget {
  const MaterialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Matériaux populaires",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),

        const Gap(30),

        MaterialCard(
          tag: 'Anglais',
          title: "L'utilisation des temps",
          contentCount: 8,
          duration: '2 heures 30 minutes',
          iconPath: IconAssets.utilisation_des_temps,
        ),
        MaterialCard(
          tag: 'Français',
          title: "Vocabulaire Thématique",
          contentCount: 4,
          duration: '1 Heures 20 Minutes',
          iconPath: IconAssets.vocabulaire_thematique,
        ),
        MaterialCard(
          tag: 'Mathématiques',
          title: 'Addition et soustraction',
          contentCount: 5,
          duration: '2 heures 30 minutes',
          iconPath: IconAssets.addition_et_soustraction,
        ),
      ],
    );
  }
}
