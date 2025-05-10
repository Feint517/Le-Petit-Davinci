import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 62,
            height: 62,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(31),
              child: Image.asset(
                'assets/images/avatars/Avatar-2.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(15),

          // User info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Alex Martin",
                style: TextStyle(
                  fontFamily: 'Bricolage Grotesque',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),
              Gap(5),
              Text(
                "Niveau 12 • 400 XP",
                style: TextStyle(
                  fontFamily: 'Bricolage Grotesque',
                  fontSize: 14,
                  color: Color(0xFF718096),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Edit button
          Container(
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF9281FF),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              child: const Text(
                "Modifier",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
