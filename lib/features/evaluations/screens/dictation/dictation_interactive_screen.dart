import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/mascot/interactive_mascot.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_controller.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_helper.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_state.dart';
import 'package:kids_learning_app/features/evaluations/controllers/dictation/dictee_interactive_controller.dart';
import 'package:kids_learning_app/features/evaluations/models/dictation/dictee_interactive_model.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/animated_progress_bar.dart';
import 'package:kids_learning_app/features/evaluations/screens/dictation/widgets/interactive_question_card.dart';

class DicteeInteractiveScreen extends GetView<DicteeInteractiveController> {
  const DicteeInteractiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // On utilise GetView qui se charge de trouver le contrôleur
    // S'assurer que le contrôleur est initialisé avant d'arriver ici
    if (!Get.isRegistered<DicteeInteractiveController>()) {
      Get.put(DicteeInteractiveController());
    }

    // Dimensions de l'écran pour la mise en page responsive
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 700;
    final isNarrowScreen = screenSize.width < 360;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F2FF),
      body: Stack(
        children: [
          // Fond décoratif
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepPurple.withValues(alpha: 0.05),
                    Colors.deepPurple.withValues(alpha: 0.01),
                  ],
                ),
              ),
            ),
          ),

          // Contenu principal
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width > 600 ? 24.0 : 12.0,
                vertical: isSmallScreen ? 8.0 : 12.0,
              ),
              child: Column(
                children: [
                  // En-tête avec titre et boutons
                  _buildHeader(context),
                  Gap(isSmallScreen ? 8 : 12),

                  // Filtres de difficulté
                  _buildDifficultyFilters(),
                  Gap(isSmallScreen ? 8 : 12),

                  // Progression globale
                  Obx(
                    () => AnimatedProgressBar(
                      progress:
                          controller.currentDicteeIndex.value /
                          (controller.dictees.isEmpty
                              ? 1
                              : controller.dictees.length),
                      height: 8,
                      label: "Progression",
                      showPercentage: true,
                      totalSteps: controller.dictees.length,
                      currentStep: controller.currentDicteeIndex.value + 1,
                    ),
                  ),
                  Gap(isSmallScreen ? 10 : 14),

                  // Carte principale de la dictée (prend la majorité de l'espace)
                  Expanded(
                    child: Obx(() {
                      // Créer une map de couleurs pour les mots
                      final Map<String, Color> wordColors = {};
                      for (final word in controller.currentDictee.wordBank) {
                        wordColors[word] = controller.getWordColor(word);
                      }

                      return InteractiveQuestionCard(
                        question: controller.currentDictee,
                        selectedWords: controller.selectedWords.toList(),
                        onWordSelected: controller.addWord,
                        onWordRemoved: controller.removeWord,
                        onAudioPlay: controller.playAudio,
                        isAudioPlaying: controller.isAudioPlaying.value,
                        isCheckingAnswer: controller.isCheckingAnswer.value,
                        isCorrect: controller.isCorrect.value,
                        showCelebration: controller.shouldShowCelebration.value,
                        audioPlayCount: controller.audioAutoPlayCount.value,
                        progressValue: controller.progressValue.value,
                        wordColors: wordColors,
                      );
                    }),
                  ),
                  Gap(isSmallScreen ? 8 : 12),

                  // Boutons de navigation et actions
                  _buildBottomActions(context),
                ],
              ),
            ),
          ),

          // Mascotte flottante
          Obx(() {
            try {
              // Vérifier si le contrôleur mascot est disponible
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
            } catch (e) {
              debugPrint('Error with mascot: $e');
            }
            // Fallback si le contrôleur n'est pas disponible
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  // Construction de l'en-tête avec titre et bouton de retour
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // Bouton de retour
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
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
                  color: Colors.deepPurple,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Titre de la section
        const Expanded(
          child: Text(
            "Dictée Interactive",
            style: TextStyle(
              fontFamily: 'Bricolage Grotesque',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),

        // Bouton d'aide
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showInfoDialog(context),
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.deepPurple,
                  size: 20,
                ),
              ),
            ),
          ),
        ),

        // Indicateur de score
        const SizedBox(width: 12),
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.amber, width: 1.5),
            ),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                const SizedBox(width: 6),
                Text(
                  "${controller.score.value} XP",
                  style: const TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Construction des filtres de difficulté
  Widget _buildDifficultyFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Row(
          children: [
            // Filtre "Tous"
            _buildFilterChip(
              label: "Tous",
              isSelected: controller.difficultyFilter.value == null,
              onTap: () => controller.filterByDifficulty(null),
              color: Colors.blue,
            ),
            const SizedBox(width: 8),

            // Filtre "Facile"
            _buildFilterChip(
              label: "Facile",
              isSelected:
                  controller.difficultyFilter.value == DifficultySetting.facile,
              onTap:
                  () => controller.filterByDifficulty(DifficultySetting.facile),
              color: Colors.green,
            ),
            const SizedBox(width: 8),

            // Filtre "Moyen"
            _buildFilterChip(
              label: "Moyen",
              isSelected:
                  controller.difficultyFilter.value == DifficultySetting.moyen,
              onTap:
                  () => controller.filterByDifficulty(DifficultySetting.moyen),
              color: Colors.amber.shade700,
            ),
            const SizedBox(width: 8),

            // Filtre "Difficile"
            _buildFilterChip(
              label: "Difficile",
              isSelected:
                  controller.difficultyFilter.value ==
                  DifficultySetting.difficile,
              onTap:
                  () => controller.filterByDifficulty(
                    DifficultySetting.difficile,
                  ),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  // Construction d'un chip de filtre
  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color, width: 1.5),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Bricolage Grotesque',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : color,
            ),
          ),
        ),
      ),
    );
  }

  // Actions en bas de l'écran
  Widget _buildBottomActions(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Bouton précédent
          if (controller.currentDicteeIndex.value > 0)
            Expanded(
              flex: 1,
              child: ElevatedButton.icon(
                onPressed:
                    controller.isCheckingAnswer.value
                        ? null
                        : controller.goToPreviousDictee,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  foregroundColor: Colors.grey.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.arrow_back_rounded, size: 18),
                label: const Text("Précédent"),
              ),
            ),

          if (controller.currentDicteeIndex.value > 0)
            const SizedBox(width: 12),

          // Bouton de vérification
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed:
                  controller.isCheckingAnswer.value
                      ? null
                      : () => controller.checkAndContinue(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                disabledBackgroundColor: Colors.deepPurple.withValues(
                  alpha: 0.5,
                ),
              ),
              icon: Icon(
                controller.selectedWords.isEmpty
                    ? Icons.lightbulb_outline
                    : (controller.currentDicteeIndex.value ==
                            controller.dictees.length - 1
                        ? Icons.check_circle_outline
                        : Icons.arrow_forward_rounded),
                size: 18,
              ),
              label: Text(
                controller.selectedWords.isEmpty
                    ? "Indice"
                    : (controller.currentDicteeIndex.value ==
                            controller.dictees.length - 1
                        ? "Terminer"
                        : "Vérifier"),
              ),
            ),
          ),

          // Bouton réinitialiser
          if (controller.selectedWords.isNotEmpty &&
              !controller.isCheckingAnswer.value)
            const SizedBox(width: 12),

          if (controller.selectedWords.isNotEmpty &&
              !controller.isCheckingAnswer.value)
            Container(
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  // Effacer tous les mots sélectionnés
                  controller.selectedWords.clear();
                  controller.progressValue.value = 0.0;
                },
                icon: const Icon(Icons.refresh_rounded, color: Colors.red),
                tooltip: "Effacer tout",
              ),
            ),
        ],
      ),
    );
  }

  // Afficher une boîte de dialogue d'information
  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.deepPurple),
                SizedBox(width: 10),
                Text("Comment jouer ?"),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoStep(
                  icon: Icons.headphones,
                  title: "Écoute",
                  description:
                      "Appuie sur le bouton audio pour entendre la dictée.",
                ),
                const SizedBox(height: 12),
                _buildInfoStep(
                  icon: Icons.text_fields,
                  title: "Compose",
                  description:
                      "Sélectionne les mots dans le bon ordre pour former la phrase.",
                ),
                const SizedBox(height: 12),
                _buildInfoStep(
                  icon: Icons.check_circle,
                  title: "Vérifie",
                  description:
                      "Appuie sur le bouton 'Vérifier' quand tu penses avoir terminé.",
                ),
                const SizedBox(height: 12),
                _buildInfoStep(
                  icon: Icons.lightbulb_outline,
                  title: "Besoin d'aide ?",
                  description:
                      "Si tu as besoin d'aide, appuie sur la mascotte.",
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("J'ai compris !"),
              ),
            ],
          ),
    );
  }

  // Construction d'une étape d'information
  Widget _buildInfoStep({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.deepPurple, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Afficher l'aide de la mascotte
  void _showMascotHelp() {
    // Montrer un message simple
    MascotHelper.showMascotDialog(
      title: "Besoin d'aide ?",
      message:
          "Écoute attentivement la phrase et sélectionne les mots dans le bon ordre !",
      state: MascotState.question,
      buttonText: "J'ai compris",
      onConfirm: () => controller.playAudio(),
    );
  }
}
