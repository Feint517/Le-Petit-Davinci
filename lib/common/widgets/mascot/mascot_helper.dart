import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/common/widgets/mascot/interactive_mascot.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_controller.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_state.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

/// Classe helper qui fournit des méthodes pour afficher la mascotte dans l'application
class MascotHelper {
  /// Affiche une boîte de dialogue flottante avec une mascotte interactive
  static void showMascotDialog({
    required String title,
    required String message,
    required MascotState state,
    MascotType? mascotType,
    String buttonText = "OK",
    VoidCallback? onConfirm,
    bool enableAnimation = true,
  }) {
    // S'assurer que le contrôleur est initialisé
    if (!Get.isRegistered<MascotController>()) {
      Get.put(MascotController());
    }
    
    // Utiliser la mascotte aléatoire ou celle spécifiée
    final mascot = mascotType ?? _getRandomMascot();
    
    // Mettre à jour l'état de la mascotte
    MascotController.to.changeMascot(mascot);
    MascotController.to.changeState(state);
    
    // Fermer tout dialogue précédent
    try {
      if (Get.isDialogOpen ?? false) {
        Get.back(closeOverlays: false);
      }
    } catch (e) {
      // Ignorer
    }
    
    // Afficher le dialogue avec la mascotte
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
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
              const Gap(15),
              
              // Mascotte interactive
              InteractiveMascot(
                mascotType: mascot,
                initialState: state,
                size: 120,
                enableAnimation: enableAnimation,
                onTap: () {
                  // Faire réagir la mascotte quand on tape dessus
                  if (state == MascotState.sad) {
                    MascotController.to.askQuestion();
                  } else if (state == MascotState.happy || state == MascotState.idle) {
                    MascotController.to.celebrate();
                  } else if (state == MascotState.question) {
                    MascotController.to.startThinking();
                  }
                },
              ),
              
              const Gap(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  if (onConfirm != null) onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: _getButtonColorForState(state),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
  
  /// Affiche une bulle de conseil avec une mascotte interactive
  static Widget buildMascotTip({
    required String message,
    MascotState state = MascotState.question,
    MascotType? mascotType,
    double size = 80,
    VoidCallback? onTap,
  }) {
    // Utiliser la mascotte spécifiée ou aléatoire
    final mascot = mascotType ?? _getRandomMascot();
    
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InteractiveMascot(
            mascotType: mascot,
            initialState: state,
            size: size,
            onTap: onTap ?? () {
              // Changer l'état aléatoirement 
              final states = [
                MascotState.happy, 
                MascotState.question, 
                MascotState.thinking
              ];
              final randomState = states[DateTime.now().millisecond % states.length];
              MascotController.to.changeState(randomState);
            },
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  /// Affiche un toast avec une mascotte pour indiquer une réussite
  static void showSuccessToast({
    required String message,
    MascotType? mascotType,
    int duration = 2,
  }) {
    final mascot = mascotType ?? _getRandomMascot();
    
    // S'assurer que le contrôleur est initialisé
    if (!Get.isRegistered<MascotController>()) {
      Get.put(MascotController());
    }
    
    // Mettre à jour l'état de la mascotte
    MascotController.to.changeMascot(mascot);
    MascotController.to.reactToCorrectAnswer();
    
    Get.snackbar(
      "Bravo !",
      message,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade800,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      duration: Duration(seconds: duration),
      icon: SizedBox(
        width: 40,
        height: 40,
        child: InteractiveMascot(
          mascotType: mascot,
          initialState: MascotState.happy,
          size: 30,
        ),
      ),
    );
  }
  
  /// Affiche une petite mascotte flottante dans un coin de l'écran
  static Widget buildFloatingMascot({
    required BuildContext context,
    MascotState initialState = MascotState.idle,
    MascotType? mascotType,
    Alignment alignment = Alignment.bottomRight,
    double size = 60,
    VoidCallback? onTap,
  }) {
    final mascot = mascotType ?? _getRandomMascot();
    
    return Positioned(
      right: alignment.x > 0 ? 20 : null,
      left: alignment.x < 0 ? 20 : null,
      bottom: alignment.y > 0 ? 20 : null,
      top: alignment.y < 0 ? 20 : null,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: InteractiveMascot(
            mascotType: mascot,
            initialState: initialState,
            size: size,
            enableAnimation: true,
          ),
        ),
      ),
    );
  }
  
  /// Obtient une mascotte aléatoire
  static MascotType _getRandomMascot() {
    final mascots = [MascotType.elephant, MascotType.owl, MascotType.panda];
    return mascots[DateTime.now().millisecond % mascots.length];
  }
  
  /// Obtient une couleur de bouton appropriée pour l'état de la mascotte
  static Color _getButtonColorForState(MascotState state) {
    switch (state) {
      case MascotState.happy:
      case MascotState.celebrating:
        return AppColors.accent;
      case MascotState.sad:
        return AppColors.secondary;
      case MascotState.question:
      case MascotState.thinking:
        return AppColors.primary;
      case MascotState.idle:
      default:
        return AppColors.primaryDeep;
    }
  }
}