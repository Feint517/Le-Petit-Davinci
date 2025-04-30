import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class LanguageOption extends StatefulWidget {
  const LanguageOption({
    super.key,
    required this.languageCode,
    required this.languageName,
    required this.flagEmoji,
    required this.description,
  });

  final String languageCode;
  final String languageName;
  final String flagEmoji;
  final String description;

  @override
  State<LanguageOption> createState() => _LanguageOptionState();
}

class _LanguageOptionState extends State<LanguageOption> {
  String selectedLanguage = 'en';
  
  @override
  Widget build(BuildContext context) {
    final isSelected = selectedLanguage == widget.languageCode;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? const Color(0xFF9281FF) : Colors.transparent,
          width: isSelected ? 2 : 0,
        ),
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
          //* Flag emoji
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F2FF),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                widget.flagEmoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const Gap(16),

          //* Language info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.languageName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const Gap(4),
                Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),

          //* Radio button
          Radio<String>(
            value: widget.languageCode,
            groupValue: selectedLanguage,
            onChanged: (value) {
              setState(() {
                selectedLanguage = value!;
              });
            },
            activeColor: AppColors.primaryDeep,
          ),
        ],
      ),
    );
  }
}
