import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

class DicteeHeader extends StatelessWidget {
  final VoidCallback onBackPressed;
  
  const DicteeHeader({
    Key? key,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button and title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                GestureDetector(
                  onTap: onBackPressed,
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF6C6C6C),
                        size: 18,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "Retour",
                        style: TextStyle(
                          fontFamily: 'Archivo',
                          fontSize: 12,
                          color: Color(0xFF6C6C6C),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Title
                Text(
                  "Dictées interactives",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 20,
                    letterSpacing: -0.06 * 20,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(IconAssets.avatar),
          ),
        ],
      ),
    );
  }
}