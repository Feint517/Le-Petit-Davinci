import 'package:flutter/material.dart';

class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  // State variables for toggle switches
  bool textToSpeechEnabled = true;
  bool highContrastEnabled = false;
  bool largerTextEnabled = false;
  bool reduceAnimationsEnabled = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF1FF), // Light purple background
      body: SafeArea(
        child: SingleChildScrollView( // Changed from Column to SingleChildScrollView for scrollability
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0, 
              right: 16.0, 
              top: 16.0,
              bottom: 24.0, // Extra bottom padding to ensure content visibility
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button with "Retour" text
                _buildBackButton(context),
                
                const SizedBox(height: 20),
                
                // Title
                const Text(
                  "Accessibilité",
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
                  "Personnalisez l'expérience d'apprentissage pour tous les besoins",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 14,
                    color: Color(0xFF4A5568),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Section title
                _buildSectionTitle("Paramètres visuels"),
                
                const SizedBox(height: 12),
                
                // Visual settings
                _buildAccessibilityCard([
                  _buildToggleOption(
                    "Texte plus grand",
                    "Augmente la taille du texte dans l'application",
                    largerTextEnabled,
                    const Color(0xFF9281FF),
                    (value) {
                      setState(() {
                        largerTextEnabled = value;
                      });
                    },
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFEDF2F7)),
                  _buildToggleOption(
                    "Mode contraste élevé",
                    "Améliore la lisibilité pour les personnes malvoyantes",
                    highContrastEnabled,
                    const Color(0xFFFC715A),
                    (value) {
                      setState(() {
                        highContrastEnabled = value;
                      });
                    },
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFEDF2F7)),
                  _buildToggleOption(
                    "Réduire les animations",
                    "Désactive ou réduit les effets d'animation",
                    reduceAnimationsEnabled,
                    const Color(0xFF13BB87),
                    (value) {
                      setState(() {
                        reduceAnimationsEnabled = value;
                      });
                    },
                  ),
                ]),
                
                const SizedBox(height: 24),
                
                // Section title
                _buildSectionTitle("Paramètres d'assistance"),
                
                const SizedBox(height: 12),
                
                // Assistance settings
                _buildAccessibilityCard([
                  _buildToggleOption(
                    "Texte à parole",
                    "Lit le contenu à haute voix pour aider la compréhension",
                    textToSpeechEnabled,
                    const Color(0xFF9281FF),
                    (value) {
                      setState(() {
                        textToSpeechEnabled = value;
                      });
                    },
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFEDF2F7)),
                  _buildNavigationOption(
                    "Sous-titres",
                    "Options pour les sous-titres dans les vidéos",
                    const Color(0xFFFC715A),
                    () {
                      // Navigate to subtitle settings
                    },
                  ),
                ]),
                
                const SizedBox(height: 24),
                
                // Section title
                _buildSectionTitle("Guide d'accessibilité"),
                
                const SizedBox(height: 12),
                
                // Guide card
                _buildGuideCard(),
              ],
            ),
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
  
  // Section title widget
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Bricolage Grotesque',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF4A5568),
      ),
    );
  }
  
  // Card container for accessibility options
  Widget _buildAccessibilityCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ensure it doesn't take extra space
        children: children,
      ),
    );
  }
  
  // Toggle option widget - optimized for space efficiency
  Widget _buildToggleOption(
    String title,
    String description,
    bool value,
    Color iconColor,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Reduced vertical padding
      child: Row(
        children: [
          // Icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.082),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getIconForTitle(title),
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Minimize height
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 13.6,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A202C),
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 11,
                    color: Color(0xFF718096),
                  ),
                  maxLines: 2, // Limit to 2 lines
                  overflow: TextOverflow.ellipsis, // Handle text overflow
                ),
              ],
            ),
          ),
          
          // Toggle switch
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF9281FF),
            activeTrackColor: const Color(0xFF9281FF).withValues(alpha: 0.5),
            inactiveTrackColor: Colors.grey.withValues(alpha: 0.3),
            inactiveThumbColor: Colors.white,
          ),
        ],
      ),
    );
  }
  
  // Navigation option widget - optimized for space efficiency
  Widget _buildNavigationOption(
    String title,
    String description,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Reduced vertical padding
        child: Row(
          children: [
            // Icon
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.082),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getIconForTitle(title),
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Minimize height
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Bricolage Grotesque',
                      fontSize: 13.6,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A202C),
                    ),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      fontFamily: 'Bricolage Grotesque',
                      fontSize: 11,
                      color: Color(0xFF718096),
                    ),
                    maxLines: 2, // Limit to 2 lines
                    overflow: TextOverflow.ellipsis, // Handle text overflow
                  ),
                ],
              ),
            ),
            
            // Forward arrow
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Color(0xFF1A202C),
            ),
          ],
        ),
      ),
    );
  }
  
  // Guide card widget - optimized for responsiveness
  Widget _buildGuideCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F2FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF9281FF).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Add this to ensure it doesn't take extra space
        children: [
          Row(
            children: const [
              Icon(
                Icons.info_outline,
                color: Color(0xFF9281FF),
                size: 20,
              ),
              SizedBox(width: 8),
              Expanded( // Wrap text in Expanded to prevent overflow
                child: Text(
                  "Guide d'accessibilité",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A202C),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "Découvrez comment utiliser au mieux nos fonctionnalités d'accessibilité pour personnaliser l'expérience d'apprentissage en fonction des besoins spécifiques de votre enfant.",
            style: TextStyle(
              fontFamily: 'Bricolage Grotesque',
              fontSize: 12,
              color: Color(0xFF4A5568),
            ),
          ),
          const SizedBox(height: 12),
          // Align button to ensure proper sizing
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to accessibility guide
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9281FF),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Voir le guide",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to get icon based on option title
  IconData _getIconForTitle(String title) {
    switch (title) {
      case "Texte plus grand":
        return Icons.text_fields;
      case "Mode contraste élevé":
        return Icons.contrast;
      case "Réduire les animations":
        return Icons.animation;
      case "Texte à parole":
        return Icons.record_voice_over;
      case "Sous-titres":
        return Icons.closed_caption;
      default:
        return Icons.settings_accessibility;
    }
  }
}