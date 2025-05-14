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
    
    // Obtenir la couleur et l'icône en fonction de l'état
    final Color stateColor = _getButtonColor(mood);
    final Color bgColor = stateColor.withOpacity(0.05);
    
    // Obtenir l'icône appropriée pour l'état
    IconData stateIcon;
    switch (mood) {
      case MascotState.happy:
        stateIcon = Icons.sentiment_very_satisfied_rounded;
        break;
      case MascotState.celebrating:
        stateIcon = Icons.celebration_rounded;
        break;
      case MascotState.sad:
        stateIcon = Icons.sentiment_dissatisfied_rounded;
        break;
      case MascotState.question:
        stateIcon = Icons.help_rounded;
        break;
      case MascotState.thinking:
        stateIcon = Icons.psychology_rounded;
        break;
      case MascotState.idle:
      default:
        stateIcon = Icons.emoji_emotions_rounded;
        break;
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: stateColor.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Décoration d'arrière-plan
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(60),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    topRight: Radius.circular(60),
                  ),
                ),
              ),
            ),
            
            // Contenu principal
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Titre avec icône
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        stateIcon,
                        color: stateColor,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: stateColor,
                            fontFamily: "BricolageGrotesque",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Mascotte interactive avec cercle décoratif
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: bgColor,
                      border: Border.all(color: stateColor.withOpacity(0.1), width: 2),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: InteractiveMascot(
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
                  ),

                  const SizedBox(height: 20),
                  // Message avec style amélioré
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: stateColor.withOpacity(0.1)),
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 16, 
                        color: AppColors.textPrimary,
                        fontFamily: "BricolageGrotesque",
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Bouton avec ombre et effet d'élévation
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [
                          stateColor,
                          stateColor.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: stateColor.withOpacity(0.3),
                          offset: const Offset(0, 5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        if (onConfirm != null) onConfirm!();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontFamily: "BricolageGrotesque",
                        ),
                      ),
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
