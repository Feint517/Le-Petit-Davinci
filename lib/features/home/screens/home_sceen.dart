import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/custom_app_bar.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_controller.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_helper.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_state.dart';
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
    // Toujours afficher le tutoriel, quelle que soit la valeur de is_first_launch
    showTutorial();

    // On ne met pas à jour la valeur pour qu'elle reste true
    // Cela permet d'afficher le tutoriel à chaque démarrage
  }

  void showTutorial() {
    TutorialCoachMark(
      targets: targets,
      colorShadow: AppColors.black,
      textSkip: "PASSER",
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        debugPrint("Tutoriel terminé");
      },
      onSkip: () {
        debugPrint("Tutoriel ignoré");
        return true;
      },
    ).show(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
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

                  // Conseil avec mascotte interactive
                  MascotHelper.buildMascotTip(
                    message: "Clique sur une matière pour commencer à apprendre, ou sur un jeu pour t'amuser !",
                    state: MascotState.question,
                    mascotType: MascotType.owl,
                    onTap: () {
                      // Changer l'état de la mascotte quand on tape dessus
                      MascotController.to.changeState(MascotState.happy);

                      // Afficher un message différent
                      MascotHelper.showMascotDialog(
                        title: "Astuce",
                        message: "Tu peux continuer ton apprentissage où tu t'étais arrêté. Choisis une matière pour commencer !",
                        state: MascotState.thinking,
                        mascotType: MascotType.owl,
                      );
                    },
                  ),

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

          // Mascotte flottante
          MascotHelper.buildFloatingMascot(
            context: context,
            initialState: MascotState.idle,
            mascotType: MascotType.elephant,
            onTap: () {
              // Changer l'état de la mascotte et afficher un dialogue
              MascotController.to.celebrate();

              // Afficher un toast avec la mascotte
              MascotHelper.showSuccessToast(
                message: "Tu progresses bien ! Continue comme ça !",
                mascotType: MascotType.elephant,
              );
            },
          ),
        ],
      ),
    );
  }
}
