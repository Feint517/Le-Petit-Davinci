import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/common/widgets/stat_card.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class PrimarySection extends StatelessWidget {
  const PrimarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 0),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Bonjour Younes',
                      style: TextStyle(fontSize: 10, color: Color(0xff494949)),
                    ),
                    Text(
                      'March, 17 2025',
                      style: TextStyle(fontSize: 10, color: Color(0xff494949)),
                    ),
                  ],
                ),
                const Gap(5),
                const Text(
                  'Content de te revoir',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const Gap(20),

                // *Cards Row
                Row(
                  children: [
                    //* Leçon
                    Expanded(
                      child: StatCard(
                        title: 'Leçon',
                        value: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '24',
                                style: TextStyle(
                                  color: AppColors.primaryDeep,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '/35',
                                style: TextStyle(
                                  color: Color(0xffC3C3C3),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        icon: SvgAssets.solar_notebook_bookmark_linear,
                        actionLabel: 'Continuer à apprendre',
                        actionColor: Color(0xFF9281FF),
                      ),
                    ),

                    const SizedBox(width: 16),

                    //* Points
                    Expanded(
                      child: StatCard(
                        title: 'Points',
                        value: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '400',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '/620',
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        icon: SvgAssets.star,
                        actionLabel: 'Obtenez des points',
                        actionColor: Color(0xFFFF725E),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(24),

          //* Featured Lesson Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF9281FF),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* Left side - Text
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Chip
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Text(
                              'Français',
                              style: TextStyle(
                                color: Color(0xFFFF725E),
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Vocabulaire thématique',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                '4 Contenu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                height: 5,
                                width: 5,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffFDCFFE),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '1 Heures 20 Minutes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Continue button
                          SizedBox(
                            width: 165,
                            height: 26,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Continuer à apprendre',
                                style: TextStyle(
                                  color: Color(0xFF9281FF),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Right side - Image
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Image.asset(
                        ImageAssets.chat_character,

                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
