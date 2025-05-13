import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/common/widgets/common_header.dart';
import 'package:kids_learning_app/features/personalization/screens/language_selection/widgets/info_section.dart';
import 'package:kids_learning_app/features/personalization/screens/language_selection/widgets/language_option.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF1FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonHeader(),
              const Gap(20),

              InfoSection(),
              const Gap(24),

              LanguageOption(
                languageCode: 'fr',
                languageName: 'Français',
                flagEmoji: '🇫🇷',
                description: 'Langue principale',
              ),
              const Gap(12),
              LanguageOption(
                languageCode: 'en',
                languageName: 'English',
                flagEmoji: '🇬🇧',
                description: 'Langue secondaire',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: Switch to stateless widget and use Getx for state management