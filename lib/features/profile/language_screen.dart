import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // Default selected language
  String selectedLanguage = 'fr';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF1FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              _buildBackButton(context),
              
              const SizedBox(height: 20),
              
              // Title
              const Text(
                "Langue d'apprentissage",
                style: TextStyle(
                  fontFamily: 'Bricolage Grotesque',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Description
              const Text(
                "Choisissez la langue dans laquelle vous souhaitez apprendre",
                style: TextStyle(
                  fontFamily: 'Bricolage Grotesque',
                  fontSize: 14,
                  color: Color(0xFF4A5568),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Language options
              _buildLanguageOption(
                languageCode: 'fr',
                languageName: 'Français',
                flagEmoji: '🇫🇷',
                description: 'Langue principale',
              ),
              
              const SizedBox(height: 12),
              
              _buildLanguageOption(
                languageCode: 'en',
                languageName: 'English',
                flagEmoji: '🇬🇧',
                description: 'Secondary language',
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Back button widget
  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Row(
        children: const [
          Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF6C6C6C),
            size: 18,
          ),
          SizedBox(width: 5),
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
    );
  }
  
  // Language option widget
  Widget _buildLanguageOption({
    required String languageCode,
    required String languageName,
    required String flagEmoji,
    required String description,
  }) {
    final isSelected = selectedLanguage == languageCode;
    
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
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Flag emoji
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F2FF),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                flagEmoji,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Language info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageName,
                  style: const TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 12,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
          
          // Radio button
          Radio<String>(
            value: languageCode,
            groupValue: selectedLanguage,
            onChanged: (value) {
              setState(() {
                selectedLanguage = value!;
              });
            },
            activeColor: const Color(0xFF9281FF),
          ),
        ],
      ),
    );
  }
}