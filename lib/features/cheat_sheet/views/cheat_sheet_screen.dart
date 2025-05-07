import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/cheat_sheet/views/widgets/category_chip.dart';
import 'package:kids_learning_app/features/cheat_sheet/views/widgets/cheat_sheet_card.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class CheatSheetScreen extends StatelessWidget {
  const CheatSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Header section
              CommonHeader(),
              const Gap(AppSizes.spaceBtwSections),

              //* Title and description
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(SvgAssets.abc, height: 40, width: 40),
                    const Gap(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Aide-mémoire Français',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A202C),
                              fontFamily: 'BricolageGrotesque',
                            ),
                          ),
                          const Gap(4),
                          const Text(
                            'Fiches de référence pour un apprentissage rapide',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF718096),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(AppSizes.spaceBtwSections),

              //* Category chips row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryChip(label: 'Alphabet', color: Colors.blue[300]!),
                    CategoryChip(label: 'Mois', color: Colors.red[300]!),
                    CategoryChip(label: 'Jours', color: Colors.pink[300]!),
                    CategoryChip(label: 'Heurs', color: Colors.amber[400]!),
                    CategoryChip(label: 'Date', color: Colors.green[300]!),
                  ],
                ),
              ),
              const Gap(AppSizes.defaultSpace),

              //* Alphabet French Cheat Sheet
              CheatSheetCard(
                title: 'Alphabet Français',
                color: Colors.blue[300]!,
                icon: Icons.abc,
                columns: const ['', '', ''],
                rows: const [
                  ['A', 'B', 'C'],
                  ['D', 'E', 'F'],
                  ['G', 'H', 'I'],
                  ['J', 'K', 'L'],
                  ['M', 'N', 'O'],
                  ['P', 'Q', 'R'],
                  ['S', 'T', 'U'],
                  ['V', 'W', 'X'],
                  ['Y', 'Z', ''],
                ],
                alternateRowColor: Colors.blue[100]!,
              ),
              const Gap(AppSizes.spaceBtwItems),

              //* Months Cheat Sheet
              CheatSheetCard(
                title: 'Mois',
                color: Colors.red[300]!,
                icon: Icons.calendar_month,
                columns: const ['English', 'Français'],
                rows: const [
                  ['January', 'Janvier'],
                  ['February', 'Février'],
                  ['March', 'Mars'],
                  ['April', 'Avril'],
                  ['May', 'Mai'],
                  ['June', 'Juin'],
                  ['July', 'Juillet'],
                  ['August', 'Août'],
                  ['September', 'Septembre'],
                  ['October', 'Octobre'],
                  ['November', 'Novembre'],
                  ['December', 'Décembre'],
                ],
                alternateRowColor: Colors.red[100]!,
              ),
              const Gap(AppSizes.spaceBtwItems),

              //* Days & Weeks Cheat Sheet
              CheatSheetCard(
                title: 'Jours et Semaines',
                color: Colors.pink[300]!,
                icon: Icons.calendar_today,
                columns: const ['English', 'Français'],
                rows: const [
                  ['Today', 'Aujourd\'hui'],
                  ['Tomorrow', 'Demain'],
                  ['Yesterday', 'Hier'],
                  ['Day Before Yesterday', 'Avant-hier'],
                  ['Day After Tomorrow', 'Après-demain'],
                  ['This Week', 'Cette semaine'],
                  ['Last Week', 'La semaine dernière'],
                  ['Next Week', 'La semaine prochaine'],
                  ['Weekday', 'Jour de la semaine'],
                  ['Weekend', 'Fin de semaine'],
                ],
                alternateRowColor: Colors.pink[100]!,
              ),
              const Gap(AppSizes.spaceBtwItems),

              //* Time of Day Cheat Sheet
              CheatSheetCard(
                title: 'Moments de la Journée',
                color: Colors.amber[400]!,
                icon: Icons.access_time,
                columns: const ['English', 'Français'],
                rows: const [
                  ['Morning', 'Matin'],
                  ['Afternoon', 'Après-midi'],
                  ['Evening', 'Soir'],
                  ['Night', 'Nuit'],
                  ['Mid-night', 'Minuit'],
                  ['Late', 'Tard'],
                  ['Early', 'Tôt'],
                  ['Later', 'Plus tard'],
                  ['Dusk', 'Crépuscule'],
                  ['Dawn', 'Aube'],
                  ['Hour', 'Heure'],
                  ['Minutes', 'Minutes'],
                  ['Seconds', 'Secondes'],
                ],
                alternateRowColor: Colors.amber[100]!,
              ),
              const Gap(AppSizes.spaceBtwItems),

              //* Date Cheat Sheet
              CheatSheetCard(
                title: 'Date',
                color: Colors.green[300]!,
                icon: Icons.date_range,
                columns: const ['English', 'Français'],
                rows: const [
                  ['1st', 'Premier'],
                  ['2nd', 'Deuxième'],
                  ['3rd', 'Troisième'],
                  ['4th', 'Quatrième'],
                  ['5th', 'Cinquième'],
                  ['6th', 'Sixième'],
                  ['7th', 'Septième'],
                  ['8th', 'Huitième'],
                  ['9th', 'Neuvième'],
                  ['10th', 'Dixième'],
                  ['20th', 'Vingtième'],
                  ['30th', 'Trentième'],
                ],
                alternateRowColor: Colors.green[100]!,
              ),
              const Gap(AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
