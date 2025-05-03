import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/features/practice/controllers/association/association_controller.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/description_section.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/exercise_content.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/exercise_dropdown.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/navigation_footer.dart';
import 'package:kids_learning_app/features/practice/screens/association/widgets/points_indicator.dart';
import 'package:kids_learning_app/features/practice/screens/writing/widgets/control_buttons.dart';
import 'package:kids_learning_app/features/personalization/screens/profile/widgets/profile_header.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';



// Main Screen Widget
class AssociationActivitiesScreen extends StatelessWidget {
  const AssociationActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AssociationController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Column(
            children: [
              const ProfileHeader(activeIcon: false),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ExerciseDropdown(),

                        ExerciseContent(),

                        ControlButtons(),

                        PointsIndicator(),

                        DescriptionWidget(),

                        NavigationFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}