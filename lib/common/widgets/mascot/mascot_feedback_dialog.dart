import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/mascot/interactive_mascot.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_controller.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_state.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

/// Widget de dialogue avec la mascotte interactive pour donner du feedback
class MascotFeedbackDialog extends StatelessWidget {
  final String title;
  final String message;
  final MascotState mood;
  final String buttonText;
  final VoidCallback? onConfirm;
  final MascotType? mascotType;

  const MascotFeedbackDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.mood,
    this.buttonText = "OK",
    this.onConfirm,
    this.mascotType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // S'assurer que le contrôleur est initialisé
    if (!Get.isRegistered<MascotController>()) {
      Get.put(MascotController());
    }

    // Utiliser le type de mascotte spécifié ou celui du contrôleur
    final mascot = mascotType ?? MascotController.to.currentMascot.value;

    // Mettre à jour l'état de la mascotte
    MascotController.to.changeState(mood);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDeep,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Mascotte interactive
            InteractiveMascot(
              mascotType: mascot,
              initialState: mood,
              size: 120,
              enableAnimation: true,
              onTap: () {
                // Faire réagir la mascotte quand on tape dessus
                if (mood == MascotState.sad) {
                  MascotController.to.askQuestion();
                } else if (mood == MascotState.happy) {
                  MascotController.to.celebrate();
                }
              },
            ),

            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back();
                if (onConfirm != null) onConfirm!();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: _getButtonColor(mood),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }

  Color _getButtonColor(MascotState state) {
    switch (state) {
      case MascotState.happy:
      case MascotState.celebrating:
        return AppColors.succuss;
      case MascotState.sad:
        return AppColors.accent2;
      case MascotState.question:
      case MascotState.thinking:
        return AppColors.primary;
      default:
        return AppColors.primaryDeep;
    }
  }
}
