import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class CustomPopupDialog extends StatelessWidget {
  /// A reusable custom popup dialog widget
  ///
  /// [title] - The popup dialog title
  /// [content] - The main content/message of the popup
  /// [primaryButtonText] - Text for the primary action button
  /// [primaryButtonColor] - Color for the primary button (defaults to primary color)
  /// [secondaryButtonText] - Optional text for the secondary button (usually cancel)
  /// [secondaryButtonColor] - Color for the secondary button (defaults to white)
  /// [onPrimaryButtonPressed] - Callback function when primary button is pressed
  /// [onSecondaryButtonPressed] - Callback function when secondary button is pressed
  /// [icon] - Optional icon to display above the title
  /// [iconColor] - Color for the icon
  
  const CustomPopupDialog({
    super.key,
    required this.title,
    required this.content,
    required this.primaryButtonText,
    this.primaryButtonColor = AppColors.primaryDeep,
    this.secondaryButtonText,
    this.secondaryButtonColor = AppColors.white,
    required this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
    this.icon,
    this.iconColor = AppColors.primaryDeep,
  });

  final String title;
  final String content;
  final String primaryButtonText;
  final Color primaryButtonColor;
  final String? secondaryButtonText;
  final Color secondaryButtonColor;
  final VoidCallback onPrimaryButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;
  final IconData? icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSizes.md),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: iconColor,
                  size: 48,
                ),
                const SizedBox(height: AppSizes.sm),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: AppSizes.defaultSpace),
              _buildButtons(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    // If we only have a primary button
    if (secondaryButtonText == null) {
      return ElevatedButton(
        onPressed: onPrimaryButtonPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryButtonColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: const Size(double.infinity, 40),
        ),
        child: Text(primaryButtonText),
      );
    }
    
    // If we have both primary and secondary buttons
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onSecondaryButtonPressed ?? () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryButtonColor,
              foregroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              minimumSize: const Size(0, 40),
            ),
            child: Text(secondaryButtonText!),
          ),
        ),
        const SizedBox(width: AppSizes.sm),
        Expanded(
          child: ElevatedButton(
            onPressed: onPrimaryButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryButtonColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              minimumSize: const Size(0, 40),
            ),
            child: Text(primaryButtonText),
          ),
        ),
      ],
    );
  }
}