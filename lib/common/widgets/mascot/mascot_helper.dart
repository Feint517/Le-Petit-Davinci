import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

    // Obtenir la couleur principale basée sur l'état de la mascotte
    final Color stateColor = _getButtonColorForState(state);
    final Color bgColor = stateColor.withOpacity(0.05);
    
    // Obtenir l'icône appropriée selon l'état
    IconData stateIcon = _getIconForState(state);

    // Afficher le dialogue avec la mascotte
    Get.dialog(
      Dialog(
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
                        const Gap(10),
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
                    const Gap(20),

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
                        initialState: state,
                        size: 120,
                        enableAnimation: enableAnimation,
                        onTap: () {
                          // Faire réagir la mascotte quand on tape dessus
                          if (state == MascotState.sad) {
                            MascotController.to.askQuestion();
                          } else if (state == MascotState.happy ||
                              state == MascotState.idle) {
                            MascotController.to.celebrate();
                          } else if (state == MascotState.question) {
                            MascotController.to.startThinking();
                          }
                        },
                      ),
                    ),

                    const Gap(20),
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
                    const Gap(24),
                    
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
                          if (onConfirm != null) onConfirm();
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
      ),
      barrierDismissible: false,
    );
  }

  /// Retourne l'icône appropriée en fonction de l'état de la mascotte
  static IconData _getIconForState(MascotState state) {
    switch (state) {
      case MascotState.happy:
        return Icons.sentiment_very_satisfied_rounded;
      case MascotState.celebrating:
        return Icons.celebration_rounded;
      case MascotState.sad:
        return Icons.sentiment_dissatisfied_rounded;
      case MascotState.question:
        return Icons.help_rounded;
      case MascotState.thinking:
        return Icons.psychology_rounded;
      case MascotState.idle:
      default:
        return Icons.emoji_emotions_rounded;
    }
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
    
    // Obtenir la couleur en fonction de l'état
    final Color stateColor = _getButtonColorForState(state);
    final Color bgColor = Colors.white;
    final IconData stateIcon = _getIconForState(state);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: stateColor.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 5),
            spreadRadius: 1,
          ),
        ],
        border: Border.all(
          color: stateColor.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Décoration d'arrière-plan
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: stateColor.withOpacity(0.05),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(60),
                ),
              ),
            ),
          ),
          
          // Contenu principal
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Mascotte interactive
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: stateColor.withOpacity(0.1),
                    border: Border.all(
                      color: stateColor.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: InteractiveMascot(
                    mascotType: mascot,
                    initialState: state,
                    size: size,
                    enableAnimation: true,
                    onTap: onTap ?? () {
                      // Changer l'état aléatoirement
                      final states = [
                        MascotState.happy,
                        MascotState.question,
                        MascotState.thinking,
                      ];
                      final randomState =
                          states[DateTime.now().millisecond % states.length];
                      MascotController.to.changeState(randomState);
                    },
                  ),
                ),
                const Gap(16),
                
                // Message avec icône
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icône d'état
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: stateColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: stateColor.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              stateIcon,
                              color: stateColor,
                              size: 16,
                            ),
                            const Gap(8),
                            Text(
                              _getStateTitle(state),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: stateColor,
                                fontFamily: "BricolageGrotesque",
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Message
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "BricolageGrotesque",
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  /// Retourne un titre basé sur l'état de la mascotte
  static String _getStateTitle(MascotState state) {
    switch (state) {
      case MascotState.happy:
        return "Super !";
      case MascotState.celebrating:
        return "Bravo !";
      case MascotState.sad:
        return "Oh non !";
      case MascotState.question:
        return "Astuce";
      case MascotState.thinking:
        return "Hmm...";
      case MascotState.idle:
      default:
        return "Conseil";
    }
  }

  /// Affiche un toast avec une mascotte pour indiquer une réussite
  static void showSuccessToast({
    required String message,
    MascotType? mascotType,
    int duration = 2,
    MascotState state = MascotState.happy,
  }) {
    final mascot = mascotType ?? _getRandomMascot();

    // S'assurer que le contrôleur est initialisé
    if (!Get.isRegistered<MascotController>()) {
      Get.put(MascotController());
    }

    // Mettre à jour l'état de la mascotte
    MascotController.to.changeMascot(mascot);
    MascotController.to.reactToCorrectAnswer();

    // Obtenir la couleur principale basée sur l'état
    final Color stateColor = _getButtonColorForState(state);
    final IconData stateIcon = _getIconForState(state);
    final String stateTitle = _getStateTitle(state);

    // Créer un widget personnalisé pour le snackbar
    final Widget customSnackContent = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            stateColor,
            stateColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: stateColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 5),
            spreadRadius: 1,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          // Mascotte avec cercle décoratif
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            padding: const EdgeInsets.all(4),
            child: InteractiveMascot(
              mascotType: mascot,
              initialState: state,
              size: 40,
              enableAnimation: true,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titre avec icône
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      stateIcon,
                      color: Colors.white,
                      size: 16,
                    ),
                    const Gap(6),
                    Text(
                      stateTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: "BricolageGrotesque",
                      ),
                    ),
                  ],
                ),
                const Gap(4),
                // Message
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontFamily: "BricolageGrotesque",
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Bouton de fermeture
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.close_rounded,
              color: Colors.white.withOpacity(0.8),
              size: 20,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
    
    // Afficher le snackbar sans utiliser userInputForm
    Get.snackbar(
      "", // Titre vide
      "", // Message vide
      backgroundColor: Colors.transparent,
      colorText: Colors.white,
      duration: Duration(seconds: duration),
      snackPosition: SnackPosition.TOP,
      borderRadius: 0,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      messageText: customSnackContent,
      titleText: const SizedBox.shrink(),
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
    final Color stateColor = _getButtonColorForState(initialState);

    return Positioned(
      right: alignment.x > 0 ? 20 : null,
      left: alignment.x < 0 ? 20 : null,
      bottom: alignment.y > 0 ? 20 : null,
      top: alignment.y < 0 ? 20 : null,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.95),
              ],
              center: Alignment.center,
              radius: 0.8,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: stateColor.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
                spreadRadius: 2,
              ),
            ],
            border: Border.all(
              color: stateColor.withOpacity(0.2),
              width: 2,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: stateColor.withOpacity(0.05),
              border: Border.all(
                color: stateColor.withOpacity(0.15),
                width: 1.5,
              ),
            ),
            child: InteractiveMascot(
              mascotType: mascot,
              initialState: initialState,
              size: size,
              enableAnimation: true,
            ),
          ),
        ),
      )
      .animate()
      .scale(
        begin: const Offset(0.8, 0.8),
        end: const Offset(1.0, 1.0),
        curve: Curves.elasticOut,
        duration: const Duration(milliseconds: 800),
      )
      .then()
      .slideY(
        begin: 0.2,
        end: 0,
        curve: Curves.easeOutQuad,
        duration: const Duration(milliseconds: 400),
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
