import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/mascot/interactive_mascot.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_controller.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_state.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

// Ces enums sont conservés pour maintenir la compatibilité avec le code existant
enum MascotMood { happy, sad, question }

class MascotFeedbackDialog extends StatelessWidget {
  final String title;
  final String message;
  final MascotType mascotType;
  final MascotState mascotState;
  final VoidCallback onConfirm;
  final String buttonText;

  const MascotFeedbackDialog({
    super.key,
    required this.title,
    required this.message,
    required this.mascotType,
    required this.mascotState,
    required this.onConfirm,
    this.buttonText = "OK",
  });

  @override
  Widget build(BuildContext context) {
    // S'assurer que le contrôleur est initialisé
    if (!Get.isRegistered<MascotController>()) {
      Get.put(MascotController());
    }

    // Mettre à jour l'état de la mascotte dans le contrôleur
    MascotController.to.changeMascot(mascotType);
    MascotController.to.changeState(mascotState);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InteractiveMascot(
                mascotType: mascotType,
                initialState: mascotState,
                size: 120,
                onTap: () {
                  // Changer l'état de la mascotte quand on tape dessus
                  if (mascotState == MascotState.sad) {
                    MascotController.to.askQuestion();
                  } else if (mascotState == MascotState.happy) {
                    MascotController.to.celebrate();
                  }
                },
              ),
              const Gap(12),

              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryDeep,
                      ),
                    ),
                    const Gap(8),

                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.grey,
                      ),
                    ),
                    const Gap(12),

                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          onConfirm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _getButtonColor(),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                        ),
                        child: Text(buttonText),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getButtonColor() {
    switch (mascotState) {
      case MascotState.happy:
      case MascotState.celebrating:
        return AppColors.accent;
      case MascotState.sad:
        return AppColors.secondary;
      case MascotState.question:
      case MascotState.thinking:
        return AppColors.primary;
      default:
        return AppColors.primaryDeep;
    }
  }
}

// Convertir d'un ancien MascotMood vers le nouveau MascotState
MascotState _convertMoodToState(MascotMood mood) {
  switch (mood) {
    case MascotMood.happy:
      return MascotState.happy;
    case MascotMood.sad:
      return MascotState.sad;
    case MascotMood.question:
      return MascotState.question;
    default:
      return MascotState.idle;
  }
}

// Fonction pour afficher un dialogue avec la mascotte
void showMascotFeedback({
  required String title,
  required String message,
  required MascotMood mood,
  VoidCallback? onConfirm,
  String buttonText = "OK",
}) {
  final mascots = [MascotType.owl, MascotType.elephant, MascotType.panda];
  final randomMascot = mascots[DateTime.now().millisecond % mascots.length];
  final mascotState = _convertMoodToState(mood);

  try {
    if (Get.isDialogOpen ?? false) {
      Get.back(closeOverlays: false);
    }
  } catch (e) {}

  Get.dialog(
    MascotFeedbackDialog(
      title: title,
      message: message,
      mascotType: randomMascot,
      mascotState: mascotState,
      onConfirm: onConfirm ?? () {},
      buttonText: buttonText,
    ),
    barrierDismissible: false,
  );
}

void showSuccessAnimation() {
  showMascotFeedback(
    title: "🎉 Félicitations! 🎉",
    message: "Tu as gagné 5 points! Continue comme ça!",
    mood: MascotMood.happy,
    buttonText: "Super!",
  );
}

void showFeedback(String title, String message, {int duration = 2}) {
  MascotMood mood;

  if (title.contains("Bravo") || title.contains("Félicitations")) {
    mood = MascotMood.happy;
  } else if (title.contains("Attention") || title.contains("Essaie")) {
    mood = MascotMood.sad;
  } else {
    mood = MascotMood.question;
  }

  showMascotFeedback(title: title, message: message, mood: mood);
}
