import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/cheat_sheet/controllers/cheat_sheet_controller.dart';
import 'package:kids_learning_app/features/cheat_sheet/views/widgets/category_chip.dart';
import 'package:kids_learning_app/features/cheat_sheet/views/widgets/cheat_sheet_card.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class CheatSheetScreen extends StatelessWidget {
  const CheatSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(CheatSheetController());
    
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
              
              //* Subject Selector Tabs
              _buildSubjectTabs(controller),
              const Gap(AppSizes.spaceBtwItems),

              //* Title and description
              Obx(() => _buildTitleSection(controller)),
              
              const Gap(AppSizes.spaceBtwSections),
              
              //* Category chips row
              Obx(() => _buildCategoryChips(controller)),
              const Gap(AppSizes.defaultSpace),
              
              //* Cheat Sheet Cards
              Obx(() => _buildCheatSheetCards(controller)),
              
              const Gap(AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSubjectTabs(CheatSheetController controller) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Obx(() => Row(
        children: [
          _buildTabButton(
            title: 'Français',
            isActive: controller.selectedSubject.value == 'French',
            icon: SvgAssets.abc,
            onTap: () => controller.switchSubject('French'),
            color: AppColors.primary,
          ),
          _buildTabButton(
            title: 'Mathématiques',
            isActive: controller.selectedSubject.value == 'Math',
            icon: SvgAssets.math_icon,
            onTap: () => controller.switchSubject('Math'),
            color: AppColors.accent,
          ),
        ],
      )),
    );
  }
  
  Widget _buildTabButton({
    required String title,
    required bool isActive,
    required String icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? color.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  height: 20,
                  width: 20,
                  color: isActive ? color : Colors.grey,
                ),
                const Gap(8),
                Text(
                  title,
                  style: TextStyle(
                    color: isActive ? color : Colors.grey,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildTitleSection(CheatSheetController controller) {
    final isFrench = controller.selectedSubject.value == 'French';
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            isFrench ? SvgAssets.abc : SvgAssets.math_icon,
            height: 40,
            width: 40,
            color: isFrench ? AppColors.primary : AppColors.accent,
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isFrench ? 'Aide-mémoire Français' : 'Aide-mémoire Mathématiques',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isFrench ? AppColors.primary : AppColors.accent,
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
    );
  }
  
  Widget _buildCategoryChips(CheatSheetController controller) {
    final categories = controller.currentCategories;
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = controller.selectedCategory.value == category.name;
          
          return CategoryChip(
            label: category.name,
            color: category.color,
            isSelected: isSelected,
            onTap: () => controller.setCategory(category.name),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildCheatSheetCards(CheatSheetController controller) {
    final cheatSheets = controller.filteredCheatSheets;
    
    if (cheatSheets.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'Aucune fiche disponible pour cette catégorie',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      );
    }
    
    return Column(
      children: cheatSheets.map((sheet) => Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
        child: CheatSheetCard(
          title: sheet.title,
          color: sheet.color,
          icon: sheet.icon,
          columns: sheet.columns,
          rows: sheet.rows,
          alternateRowColor: sheet.alternateRowColor,
        ),
      )).toList(),
    );
  }
}