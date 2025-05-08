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
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Create global keys for each item to showcase
  final GlobalKey _appBarKey = GlobalKey();
  final GlobalKey _primarySectionKey = GlobalKey();
  final GlobalKey _subjectsSectionKey = GlobalKey();
  final GlobalKey _gamesSectionKey = GlobalKey();

  // List to hold all targets
  late List<TargetFocus> targets;

  @override
  void initState() {
    super.initState();
    // Initialize the controller
    Get.put(HomeController());

    // Initialize targets
    initTargets();

    // Show tutorial after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkFirstLaunch();
    });
  }

  void initTargets() {
    targets = [
      TargetFocus(
        identify: "appBar",
        keyTarget: _appBarKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profil et progrès",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Accédez à votre profil et suivez vos progrès ici",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "primarySection",
        keyTarget: _primarySectionKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bienvenue",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Bienvenue dans votre espace d'apprentissage",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "subjectsSection",
        keyTarget: _subjectsSectionKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Matières",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Choisissez parmi différentes matières à étudier",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: "gamesSection",
        keyTarget: _gamesSectionKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jeux éducatifs",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Apprenez en vous amusant avec nos jeux éducatifs",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  Future<void> checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('is_first_launch') ?? true;

    if (isFirstLaunch) {
      showTutorial();
      await prefs.setBool('is_first_launch', false);
    }
  }

  void showTutorial() {
    TutorialCoachMark(
      targets: targets,
      colorShadow: AppColors.black,
      textSkip: "PASSER",
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("Tutoriel terminé");
      },
      onSkip: () {
        print("Tutoriel ignoré");
        return true;
      },
    ).show(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Profile and Progress
              CustomAppBar(key: _appBarKey),
              const Gap(24),

              //* Welcome Text
              PrimarySection(key: _primarySectionKey),
              const Gap(AppSizes.spaceBtwSections),

              //* Matières
              SubjectsSection(key: _subjectsSectionKey),
              const Gap(AppSizes.spaceBtwSections),

              //* Jeux éducatifs
              GamesSection(key: _gamesSectionKey),
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
