import 'package:flutter/material.dart';
import 'package:kids_learning_app/common/widgets/popups/custom_popup_dialog.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class PopupHelper {
  static void showCustomPopup({
    required BuildContext context,
    required String title,
    required String content,
    required String primaryButtonText,
    Color? primaryButtonColor,
    String? secondaryButtonText,
    Color? secondaryButtonColor,
    required VoidCallback onPrimaryButtonPressed,
    VoidCallback? onSecondaryButtonPressed,
    IconData? icon,
    Color? iconColor,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CustomPopupDialog(
        title: title,
        content: content,
        primaryButtonText: primaryButtonText,
        primaryButtonColor: primaryButtonColor ?? AppColors.primaryDeep,
        secondaryButtonText: secondaryButtonText,
        secondaryButtonColor: secondaryButtonColor ?? AppColors.white,
        onPrimaryButtonPressed: onPrimaryButtonPressed,
        onSecondaryButtonPressed: onSecondaryButtonPressed ?? () => Navigator.of(context).pop(),
        icon: icon,
        iconColor: iconColor ?? AppColors.primaryDeep,
      ),
    );
  }
  
  // Predefined popup for logout confirmation
  static void showLogoutConfirmation({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    showCustomPopup(
      context: context,
      title: 'Se déconnecter',
      content: 'Êtes-vous sûr de vouloir vous déconnecter de votre compte?',
      primaryButtonText: 'Se déconnecter',
      primaryButtonColor: AppColors.secondary,
      secondaryButtonText: 'Annuler',
      onPrimaryButtonPressed: onConfirm,
      icon: Icons.logout,
      iconColor: AppColors.secondary,
    );
  }
}