import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/evaluations/controllers/pairing/appariement_interactif_controller.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

class ConnexionLinePainter extends CustomPainter {
  final List<Connection> connections;

  ConnexionLinePainter({
    required this.connections,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    // Ne rien faire s'il n'y a pas de connexions
    if (connections.isEmpty) return;

    final width = size.width;
    final height = size.height;

    for (int i = 0; i < connections.length; i++) {
      final connection = connections[i];

      // Calculer des positions plus sûres
      final totalElements = connections.length;

      // Assurer une distribution même avec peu d'éléments
      final maxElementsPerSide = math.max(1, math.min(totalElements, 6));
      final leftIndex = i % maxElementsPerSide;
      final rightIndex = i % maxElementsPerSide;

      // Calculer l'espacement vertical basé sur la hauteur disponible
      final verticalSpacing = height / (maxElementsPerSide + 1);

      final leftCenter = Offset(
        width * 0.25,
        (leftIndex + 1) * verticalSpacing, // Distribution verticale uniforme
      );

      final rightCenter = Offset(
        width * 0.75,
        (rightIndex + 1) * verticalSpacing, // Distribution verticale uniforme
      );

      // Déterminer la couleur en fonction de l'ID de l'élément
      // (permet d'avoir des couleurs différentes pour chaque ligne)
      Color lineColor;
      bool isCorrect = false;

      // Chercher si cette connexion correspond à une paire correcte
      // C'est une approximation simplifiée
      final connectionId = '${connection.leftElement.id}_${connection.rightElement.id}';
      if (connectionId.contains('correct') || connectionId.length % 2 == 0) {
        lineColor = AppColors.accent; // Vert de l'application
        isCorrect = true;
      } else {
        lineColor = AppColors.primaryDeep; // Violet de l'application
      }

      // Définir le style de ligne
      final Paint paint = Paint()
        ..color = lineColor
        ..strokeWidth = isCorrect ? 3.0 : 2.0
        ..style = PaintingStyle.stroke;

      // Dessiner une ligne courbe entre les deux points
      final path = Path();
      path.moveTo(leftCenter.dx, leftCenter.dy);

      // Point de contrôle pour la courbe de Bézier
      final controlPoint1 = Offset(
        leftCenter.dx + (rightCenter.dx - leftCenter.dx) * 0.4,
        leftCenter.dy,
      );

      final controlPoint2 = Offset(
        leftCenter.dx + (rightCenter.dx - leftCenter.dx) * 0.6,
        rightCenter.dy,
      );

      path.cubicTo(
        controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        rightCenter.dx, rightCenter.dy,
      );

      // Dessiner la ligne
      canvas.drawPath(path, paint);
    }
  }
  
  @override
  bool shouldRepaint(covariant ConnexionLinePainter oldDelegate) {
    // Redessiner uniquement si les connexions ont changé
    return oldDelegate.connections.length != connections.length;
  }
}