import 'package:flutter/material.dart';
import 'package:kids_learning_app/features/evaluations/screens/pairing/appariement_interactif_fixed.dart';
import 'package:kids_learning_app/features/evaluations/screens/pairing/compatibility.dart';

class ExercicesAppariementScreen extends StatelessWidget {
  const ExercicesAppariementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Entourer la redirection avec une gestion d'erreur pour éviter les crashs
    return AppariementCompatibility.buildSafely(
      () => const AppariementInteractifScreen(),
      fallback: Scaffold(
        appBar: AppBar(
          title: const Text('Exercices d\'Appariement'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(
          child: Text(
            'Chargement des exercices en cours...',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}