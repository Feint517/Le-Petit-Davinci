import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/games/snake/snake.dart';
import 'package:kids_learning_app/features/games/tic-tac-toe/tic_tac_toe.dart';

class ChildHomeScreen2 extends StatefulWidget {
  const ChildHomeScreen2({super.key});

  @override
  State<ChildHomeScreen2> createState() => _ChildHomeScreen2State();
}

class _ChildHomeScreen2State extends State<ChildHomeScreen2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const SizedBox(height: 10),

          // Game Cards
          _buildGameCard(
            "echecs",
            "Échecs",
            "Développez votre meilleure stratégie",
            Color(0xFF9C84F9),
            () {},
          ),
          _buildGameCard(
            "echles",
            "Tic-Tac-Toe",
            "Développez votre meilleure stratégie",
            Color(0xFFFF6A4D),
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TicTacToe()),
              );
            },
          ),
          _buildGameCard(
            "ti-tac",
            "Serpents et échelles",
            "Développez votre meilleure stratégie",
            Color(0xFF17BF8A),
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  SnakeGame()),
              );
            },
          ),

          const SizedBox(height: 30),

          const Text(
            "Matériaux populaires",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 20),

          _buildMaterialCard(
            "Anglais",
            "L'utilisation des temps",
            8,
            "2 heures 30 minutes",
            "L'utilisation_des_temps",
          ),
          _buildMaterialCard(
            "Français",
            "Vocabulaire Thématique",
            4,
            "1 Heures 20 Minutes",
            "Vocabulaire_thématique",
          ),
          _buildMaterialCard(
            "Mathématiques",
            "Addition et soustraction",
            5,
            "2 heures 30 minutes",
            'addition_et_soustraction',
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(
    String icon,
    String title,
    String subtitle,
    Color color,
    void Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Image.asset("assets/icons/$icon.png", height: 60, width: 60),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialCard(
    String tag,
    String title,
    int contentCount,
    String duration,
    String icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffFDF2FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: Color(0xffFC715A),
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      "$contentCount Contenu",
                      style: const TextStyle(fontSize: 11),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.circle,
                      size: 10,
                      color: Color(0xffFDCFFE),
                    ),
                    const SizedBox(width: 5),
                    Text(duration, style: const TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Image.asset("assets/icons/$icon.png", height: 88),
        ],
      ),
    );
  }
}
