
import 'package:flutter/material.dart';

class ParentalControlScreen extends StatelessWidget {
  const ParentalControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF1FF), // Light purple background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                _buildBackButton(context),
                
                // User profiles row
                _buildUserProfilesRow(),
                
                const SizedBox(height: 24),
                
                // Statistics cards
                _buildStatisticsRow(),
                
                const SizedBox(height: 24),
                
                // Subject progression section
                _buildSectionTitle("Progression par matière"),
                const SizedBox(height: 16),
                _buildSubjectProgressionCard(),
                
                const SizedBox(height: 24),
                
                // Activities section
                _buildSectionTitle("Progression par matière"),
                const SizedBox(height: 16),
                _buildActivitiesSection(),
                
                const SizedBox(height: 24),
                
                // Parental control options
                _buildSectionTitle("Progression par matière"),
                const SizedBox(height: 16),
                _buildParentalControlOptions(),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // Back button with "Retour" text
  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: GestureDetector(
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
      ),
    );
  }
  
  // User profiles row with two cards
  Widget _buildUserProfilesRow() {
    return Row(
      children: [
        // Alex profile card (selected)
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF9281FF),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar
                Container(
                  width: 69,
                  height: 69,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.asset(
                      'assets/images/avatars/Avatar-2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                
                // Name
                const Text(
                  "Alex",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 13.6,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 4),
                
                // Age and level
                const Text(
                  "8 ans • Niveau 12",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11.9,
                    color: Color(0xFF718096),
                  ),
                ),
                const SizedBox(height: 8),
                
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: LinearProgressIndicator(
                    value: 0.65,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFEDF2F7),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF9281FF),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                
                // XP display
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "XP",
                      style: TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: 10.2,
                        color: Color(0xFF718096),
                      ),
                    ),
                    Text(
                      "400/620",
                      style: TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: 10.2,
                        color: Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Emma profile card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar
                Container(
                  width: 69,
                  height: 69,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.asset(
                      'assets/images/avatars/Avatar-1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                
                // Name
                const Text(
                  "Emma",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 13.6,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 4),
                
                // Age and level
                const Text(
                  "7 ans • Niveau 15",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 11.9,
                    color: Color(0xFF718096),
                  ),
                ),
                const SizedBox(height: 8),
                
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: LinearProgressIndicator(
                    value: 0.84,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFEDF2F7),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF9281FF),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                
                // XP display
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "XP",
                      style: TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: 10.2,
                        color: Color(0xFF718096),
                      ),
                    ),
                    Text(
                      "520/620",
                      style: TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: 10.2,
                        color: Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  // Statistics cards (Learning time and Rewards)
  Widget _buildStatisticsRow() {
    return Row(
      children: [
        // Learning time card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon and title
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9281FF).withOpacity(0.082),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.access_time,
                        color: Color(0xFF9281FF),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Temps",
                          style: TextStyle(
                            fontFamily: 'Bricolage Grotesque',
                            fontSize: 11.9,
                            color: Color(0xFF4A5568),
                          ),
                        ),
                        Text(
                          "d'apprentissage",
                          style: TextStyle(
                            fontFamily: 'Bricolage Grotesque',
                            fontSize: 11.9,
                            color: Color(0xFF4A5568),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Time value
                const Text(
                  "2h 15m",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 20.4,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 4),
                
                // Period
                const Text(
                  "Cette semaine",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 11.9,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Rewards card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon and title
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF7E5F).withOpacity(0.082),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.emoji_events,
                        color: Color(0xFFFC715A),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Récompenses",
                      style: TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: 11.9,
                        color: Color(0xFF4A5568),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Badges count
                const Text(
                  "12",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 20.4,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 4),
                
                // Badges text
                const Text(
                  "Badges gagnés",
                  style: TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 11.9,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  // Section title widget
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Bricolage Grotesque',
        fontSize: 11.9,
        fontWeight: FontWeight.w500,
        color: Color(0xFF4A5568),
      ),
    );
  }
  
  // Subject progression card with progress bars
  Widget _buildSubjectProgressionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Mathematics progress
          _buildSubjectProgress(
            "Mathématiques",
            0.65,
            "65%",
            const Color(0xFF9281FF),
          ),
          const SizedBox(height: 16),
          
          // French progress
          _buildSubjectProgress(
            "Français",
            0.40,
            "40%",
            const Color(0xFFFC715A),
          ),
          const SizedBox(height: 16),
          
          // English progress
          _buildSubjectProgress(
            "Anglais",
            0.20,
            "20%",
            const Color(0xFF13BB87),
          ),
        ],
      ),
    );
  }
  
  // Individual subject progress item
  Widget _buildSubjectProgress(
    String subject,
    double progress,
    String percentage,
    Color progressColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subject,
              style: const TextStyle(
                fontFamily: 'Bricolage Grotesque',
                fontSize: 11.9,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A202C),
              ),
            ),
            Text(
              percentage,
              style: const TextStyle(
                fontFamily: 'Bricolage Grotesque',
                fontSize: 11.9,
                color: Color(0xFF718096),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: const Color(0xFFEDF2F7),
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
        ),
      ],
    );
  }
  
  // Activities section with two activity cards
  Widget _buildActivitiesSection() {
    return Column(
      children: [
        // Math lesson (completed)
        _buildActivityCard(
          icon: Icons.book,
          iconBgColor: const Color(0xFF13BB87).withOpacity(0.082),
          iconColor: const Color(0xFF13BB87),
          title: "Leçon de mathématiques",
          time: "Aujourd'hui, 14:30",
          status: "Terminé",
          statusBgColor: const Color(0xFFC6F6D5),
          statusTextColor: const Color(0xFF13BB87),
        ),
        
        const SizedBox(height: 12),
        
        // French quiz (in progress)
        _buildActivityCard(
          icon: Icons.quiz,
          iconBgColor: const Color(0xFF9281FF).withOpacity(0.082),
          iconColor: const Color(0xFF9281FF),
          title: "Quiz de français",
          time: "Aujourd'hui, 15:45",
          status: "En cours",
          statusBgColor: const Color(0xFFE9D8FD),
          statusTextColor: const Color(0xFF9281FF),
        ),
      ],
    );
  }
  
  // Individual activity card
  Widget _buildActivityCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String time,
    required String status,
    required Color statusBgColor,
    required Color statusTextColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          // Icon
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontFamily: 'Bricolage Grotesque',
                          fontSize: 10.2,
                          fontWeight: FontWeight.w700,
                          color: statusTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                
                // Time
                Text(
                  time,
                  style: const TextStyle(
                    fontFamily: 'Bricolage Grotesque',
                    fontSize: 11.9,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Parental control options
 // Parental control options
Widget _buildParentalControlOptions() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure full width
    children: [
      // Time limits option
      _buildParentalControlOption(
        title: "Limites de temps",
        description: "Définir des limites quotidiennes d'utilisation",
        titleColor: const Color(0xFF9281FF),
      ),
      
      const SizedBox(height: 12),
      
      // Content access option
      _buildParentalControlOption(
        title: "Contenu accessible",
        description: "Gérer l'accès aux sujets et jeux",
        titleColor: const Color(0xFFFC715A),
      ),
    ],
  );
}
  
  // Individual parental control option
  Widget _buildParentalControlOption({
    required String title,
    required String description,
    required Color titleColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Bricolage Grotesque',
              fontSize: 13.6,
              fontWeight: FontWeight.w500,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontFamily: 'Bricolage Grotesque',
              fontSize: 11.9,
              fontWeight: FontWeight.w600,
              color: Color(0xFF718096),
            ),
          ),
        ],
      ),
    );
  }
}