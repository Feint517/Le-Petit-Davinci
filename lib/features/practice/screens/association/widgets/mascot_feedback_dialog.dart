import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

enum MascotType { owl, elephant, panda }

enum MascotMood { happy, sad, question }

class MascotFeedbackDialog extends StatelessWidget {
  final String title;
  final String message;
  final MascotType mascotType;
  final MascotMood mascotMood;
  final VoidCallback onConfirm;
  final String buttonText;

  const MascotFeedbackDialog({
    super.key,
    required this.title,
    required this.message,
    required this.mascotType,
    required this.mascotMood,
    required this.onConfirm,
    this.buttonText = "OK",
  });

  @override
  Widget build(BuildContext context) {
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
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                _getMascotImagePath(),
                height: 120,
                width: 120,
                fit: BoxFit.contain,
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

  String _getMascotImagePath() {
    String mascot = mascotType.toString().split('.').last;
    String mood = mascotMood.toString().split('.').last;
    return 'assets/images/mascots/$mascot/${mood}_$mascot.png';
  }

  Color _getButtonColor() {
    switch (mascotMood) {
      case MascotMood.happy:
        return AppColors.accent;
      case MascotMood.sad:
        return AppColors.secondary;
      case MascotMood.question:
        return AppColors.primary;
    }
  }
}

void showMascotFeedback({
  required String title,
  required String message,
  required MascotMood mood,
  VoidCallback? onConfirm,
  String buttonText = "OK",
}) {
  final mascots = [MascotType.owl, MascotType.elephant, MascotType.panda];
  final randomMascot = mascots[DateTime.now().millisecond % mascots.length];

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
      mascotMood: mood,
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
