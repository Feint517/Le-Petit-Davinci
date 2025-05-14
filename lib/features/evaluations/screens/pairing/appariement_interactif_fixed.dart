import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/mascot/interactive_mascot.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_controller.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_helper.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_state.dart';
import 'package:kids_learning_app/features/evaluations/controllers/pairing/appariement_interactif_controller.dart';
import 'package:kids_learning_app/features/evaluations/models/pairing/appariement_interactif_model.dart';
import 'package:kids_learning_app/features/evaluations/screens/pairing/compatibility.dart';
import 'package:kids_learning_app/features/evaluations/screens/pairing/widgets/appariement_progres.dart';
import 'package:kids_learning_app/features/evaluations/screens/pairing/widgets/connexion_line_painter.dart';
import 'package:kids_learning_app/features/evaluations/screens/pairing/widgets/element_appariement_card.dart';
import 'package:kids_learning_app/features/evaluations/screens/pairing/widgets/navigation_buttons.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:lottie/lottie.dart';

class AppariementInteractifScreen
    extends GetView<AppariementInteractifController> {
  const AppariementInteractifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // S'assurer que le contrôleur est initialisé de façon sécurisée
    AppariementCompatibility.getControllerSafely<
      AppariementInteractifController
    >(() => AppariementInteractifController());

    // Dimensions de l'écran pour la mise en page responsive
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;

    return Scaffold(
      backgroundColor: AppColors.light,
      body: Stack(
        children: [
          // Arrière-plan décoratif
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.purple.withValues(alpha: 0.05),
                    AppColors.primary.withValues(alpha: 0.02),
                  ],
                ),
              ),
            ),
          ),

          // Contenu principal
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: isSmallScreen ? 8.0 : 16.0,
              ),
              child: Column(
                children: [
                  // En-tête
                  _buildHeader(context),
                  Gap(isSmallScreen ? 12 : 20),

                  // Progression
                  Obx(
                    () => AppariementProgres(
                      currentIndex: controller.currentExerciceIndex.value + 1,
                      totalExercices: controller.exercices.length,
                      progress: controller.progressValue.value,
                      difficulte: controller.currentExercice.difficulte,
                    ),
                  ),
                  Gap(isSmallScreen ? 12 : 20),

                  // Contenu de l'exercice
                  Expanded(
                    child: Obx(() {
                      final exercice = controller.currentExercice;

                      // Sélectionner le widget approprié en fonction du mode d'appariement
                      switch (exercice.mode) {
                        case ModeAppariement.glisserDeposer:
                          return _buildDragDropContent(exercice);
                        case ModeAppariement.tracerLigne:
                          return _buildDrawLineContent(exercice);
                        case ModeAppariement.selection:
                          return _buildSelectionContent(exercice);
                      }
                    }),
                  ),

                  Gap(isSmallScreen ? 12 : 16),

                  // Boutons de navigation
                  Obx(
                    () => NavigationButtons(
                      onPrevious: controller.goToPreviousExercice,
                      onNext: controller.goToNextExercice,
                      onReset: controller.resetExercice,
                      isFirstQuestion:
                          controller.currentExerciceIndex.value == 0,
                      isLastQuestion:
                          controller.currentExerciceIndex.value ==
                          controller.exercices.length - 1,
                      hasStartedExercice: controller.progressValue.value > 0,
                      isCheckingAnswer: controller.isCheckingAnswer.value,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Effet de célébration
          Obx(() {
            if (controller.showCelebration.value) {
              return Positioned.fill(
                child: IgnorePointer(
                  child: AppariementCompatibility.buildSafely(
                    () => Lottie.asset(
                      AppariementCompatibility.getAssetPathSafely(
                        'assets/lottie/misc/confetti.json',
                        'assets/lottie/misc/success.json',
                      ),
                      fit: BoxFit.cover,
                    ),
                    fallback: const SizedBox.shrink(),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),

          // Mascotte flottante
          Obx(() {
            return AppariementCompatibility.buildSafely(() {
              if (Get.isRegistered<MascotController>()) {
                final mascotController = Get.find<MascotController>();
                return Positioned(
                  right: 10,
                  bottom: 80,
                  child: InteractiveMascot(
                    mascotType: mascotController.currentMascot.value,
                    initialState: mascotController.currentState.value,
                    size: 60,
                    onTap: () => _showMascotHelp(),
                  ),
                );
              }
              return const SizedBox.shrink();
            }, fallback: const SizedBox.shrink());
          }),
        ],
      ),
    );
  }

  // Construction de l'en-tête
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // Bouton de retour
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Get.back(),
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.purple,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        const Gap(16),

        // Titre de la section
        Expanded(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Exercices d'Appariement",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.purple,
                  ),
                ),
                Text(
                  controller.currentExercice.titre,
                  style: const TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 14,
                    color: Color(0xFF6A3EA1), // Version plus foncée de purple
                  ),
                ),
              ],
            ),
          ),
        ),

        // Indicateur de score
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.amber, width: 1.5),
          ),
          child: Row(
            children: [
              const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
              const Gap(6),
              Obx(
                () => Text(
                  "${controller.score.value} XP",
                  style: const TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Construction du contenu pour le mode "glisserDeposer"
  Widget _buildDragDropContent(AppariementInteractifModel exercice) {
    final leftElements = exercice.paires.map((p) => p.gauche).toList();
    final rightElements = exercice.paires.map((p) => p.droite).toList();

    // Mélanger les éléments
    leftElements.shuffle();
    rightElements.shuffle();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Description de l'exercice
            Text(
              exercice.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Bricolage Grotesque',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            const Gap(20),

            // Contenu de l'exercice
            Expanded(
              child: Row(
                children: [
                  // Éléments de gauche (draggables)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: leftElements.map((element) {
                        // Use Obx to observe reactive changes
                        return Obx(() {
                          final correctItems = controller.correctElements;
                          final incorrectItems = controller.incorrectElements;
                          final glowingItems = controller.elementsWithGlow;
                          
                          return Draggable<ElementAppariement>(
                            data: element,
                            feedback: ElementAppariementCard(
                              element: element,
                              isGlowing: true,
                              size: 100,
                            ),
                            childWhenDragging: ElementAppariementCard(
                              element: element,
                              isGlowing: false,
                              opacity: 0.3,
                            ),
                            child: ElementAppariementCard(
                              element: element,
                              isCorrect: correctItems.contains(element.id),
                              isIncorrect: incorrectItems.contains(element.id),
                              isGlowing: glowingItems.contains(element.id),
                            ),
                          );
                        });
                      }).toList(),
                    ),
                  ),

                  // Espace central avec indicateurs de direction
                  const SizedBox(
                    width: 60,
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.purple,
                        size: 30,
                      ),
                    ),
                  ),

                  // Éléments de droite (drop targets)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: rightElements.map((element) {
                        return Obx(() {
                          // Listen to the specific values we need from the controller
                          final dropped = controller.dropTargetValues[element.id];
                          final correctItems = controller.correctElements;
                          final incorrectItems = controller.incorrectElements;
                          final glowingItems = controller.elementsWithGlow;
                          
                          return DragTarget<ElementAppariement>(
                            builder: (context, candidateData, rejectedData) {
                              final bool isTargeted = candidateData.isNotEmpty;
                              final String? droppedId = dropped;
                              final bool hasItem = droppedId != null;
                              
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Zone de dépôt
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: isTargeted
                                          ? AppColors.purple.withValues(alpha: 0.1)
                                          : Colors.grey.withValues(alpha: 0.05),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: isTargeted
                                            ? AppColors.purple
                                            : Colors.grey.withValues(alpha: 0.3),
                                        width: isTargeted ? 2 : 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: hasItem
                                          ? const SizedBox.shrink()
                                          : ElementAppariementCard(
                                              element: element,
                                              isCorrect: correctItems.contains(element.id),
                                              isIncorrect: incorrectItems.contains(element.id),
                                              isGlowing: glowingItems.contains(element.id),
                                            ),
                                    ),
                                  ),
                                  
                                  // Élément déposé
                                  if (hasItem)
                                    Positioned.fill(
                                      child: Builder(builder: (context) {
                                        final droppedElement = exercice.paires
                                            .expand((p) => [p.gauche, p.droite])
                                            .firstWhere(
                                              (e) => e.id == droppedId,
                                              orElse: () => exercice.paires[0].gauche,
                                            );
                                        
                                        return ElementAppariementCard(
                                          element: droppedElement,
                                          isCorrect: correctItems.contains(droppedId),
                                          isIncorrect: incorrectItems.contains(droppedId),
                                        );
                                      }),
                                    ),
                                ],
                              );
                            },
                            onAccept: (dragged) {
                              controller.handleDrop(dragged.id, element.id);
                            },
                          );
                        });
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construction du contenu pour le mode "tracerLigne"
  Widget _buildDrawLineContent(AppariementInteractifModel exercice) {
    final leftElements = exercice.paires.map((p) => p.gauche).toList();
    final rightElements = exercice.paires.map((p) => p.droite).toList();

    // Mélanger les éléments
    rightElements.shuffle();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Description de l'exercice
            Text(
              exercice.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Bricolage Grotesque',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            const Gap(20),

            // Contenu de l'exercice avec Custom Paint pour les lignes
            Expanded(
              child: GetBuilder<AppariementInteractifController>(
                id: 'line_connections',
                builder: (_) {
                  return Obx(() {
                    // Make sure we're listening to the right observables
                    final connections = controller.connections;
                    final selected = controller.selectedLeftElement.value;
                    final correctItems = controller.correctElements;
                    final incorrectItems = controller.incorrectElements;
                    final glowingItems = controller.elementsWithGlow;
                    
                    return CustomPaint(
                      painter: ConnexionLinePainter(
                        connections: connections,
                      ),
                      child: Row(
                        children: [
                          // Éléments de gauche
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: leftElements.map((element) {
                                final isSelected = selected?.id == element.id;
                                final isCorrect = correctItems.contains(element.id);
                                final isIncorrect = incorrectItems.contains(element.id);
                                final isGlowing = glowingItems.contains(element.id);
                                
                                return GestureDetector(
                                  onTap: () => controller.selectLeftElement(element),
                                  child: ElementAppariementCard(
                                    element: element,
                                    isSelected: isSelected,
                                    isCorrect: isCorrect,
                                    isIncorrect: isIncorrect,
                                    isGlowing: isGlowing,
                                    key: ValueKey('left_${element.id}'),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
          
                          // Espace central
                          const SizedBox(width: 40),
          
                          // Éléments de droite
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: rightElements.map((element) {
                                final isCorrect = correctItems.contains(element.id);
                                final isIncorrect = incorrectItems.contains(element.id);
                                final isGlowing = glowingItems.contains(element.id);
                                
                                return GestureDetector(
                                  onTap: () {
                                    if (controller.selectedLeftElement.value != null) {
                                      controller.connectToRightElement(element);
                                    }
                                  },
                                  child: ElementAppariementCard(
                                    element: element,
                                    isCorrect: isCorrect,
                                    isIncorrect: isIncorrect,
                                    isGlowing: isGlowing,
                                    key: ValueKey('right_${element.id}'),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Construction du contenu pour le mode "selection"
  Widget _buildSelectionContent(AppariementInteractifModel exercice) {
    // Combiner tous les éléments
    final allElements = [
      ...exercice.paires.map((p) => p.gauche),
      ...exercice.paires.map((p) => p.droite),
    ];

    // Mélanger les éléments
    allElements.shuffle();

    // Créer une grille
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Description de l'exercice
            Text(
              exercice.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Bricolage Grotesque',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            const Gap(20),

            // Contenu de l'exercice en grille
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calculer le nombre de colonnes optimal en fonction de la largeur
                  final screenWidth = constraints.maxWidth;
                  final crossAxisCount = screenWidth < 400 ? 2 : 3;

                  // Calculer la taille optimale des cartes
                  final itemWidth =
                      (screenWidth - (crossAxisCount + 1) * 12) /
                      crossAxisCount;
                  final itemSize =
                      itemWidth *
                      0.9; // Légèrement plus petit pour avoir des marges

                  // Create a direct builder without Obx
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: allElements.length,
                    itemBuilder: (context, index) {
                      final element = allElements[index];
                      
                      // Use a GetBuilder instead of Obx for better state management
                      return GetBuilder<AppariementInteractifController>(
                        id: 'selection_items', // Custom ID for this builder
                        builder: (_) {
                          final isSelected = 
                              controller.firstSelectedElement.value?.id == element.id ||
                              controller.secondSelectedElement.value?.id == element.id;
                          final isCorrect = controller.correctElements.contains(element.id);
                          final isIncorrect = controller.incorrectElements.contains(element.id);
                          final isGlowing = controller.elementsWithGlow.contains(element.id);
                            
                          return GestureDetector(
                            onTap: () => controller.selectElement(element),
                            child: ElementAppariementCard(
                              element: element,
                              isSelected: isSelected,
                              isCorrect: isCorrect,
                              isIncorrect: isIncorrect,
                              isGlowing: isGlowing,
                              size: itemSize,
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Afficher l'aide de la mascotte
  void _showMascotHelp() {
    AppariementCompatibility.runSafely(() {
      final exercice = controller.currentExercice;
      String message =
          exercice.mascotMessage ?? "Associe les éléments qui vont ensemble!";

      // Obtenir la mascotte actuelle de façon sécurisée
      MascotType mascotType = MascotType.owl;
      if (Get.isRegistered<MascotController>()) {
        try {
          mascotType = Get.find<MascotController>().currentMascot.value;
        } catch (e) {
          debugPrint('Erreur récupération mascotte: $e');
        }
      }

      try {
        MascotHelper.showMascotDialog(
          title: exercice.titre,
          message: message,
          state: MascotState.question,
          mascotType: mascotType,
          buttonText: "J'ai compris",
        );
      } catch (e) {
        debugPrint('Erreur affichage dialog mascotte: $e');
        // Fallback simple en cas d'erreur
        if (Get.context != null) {
          ScaffoldMessenger.of(
            Get.context!,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
      }
    });
  }
}
