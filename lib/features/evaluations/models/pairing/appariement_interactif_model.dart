import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/assets_manager.dart';

/// Types d'exercices d'appariement
enum AppariementType {
  imageMot, // Associer une image à un mot
  imageCouleur, // Associer une image à sa couleur
  imageForme, // Associer une image à sa forme
  motDefinition, // Associer un mot à sa définition
  sonImage, // Associer un son à une image
  animauxHabitat, // Associer un animal à son habitat
  nombreQuantite, // Associer un nombre à une quantité
}

/// Niveaux de difficulté
enum NiveauDifficulte {
  facile,
  moyen,
  difficile
}

/// Mode d'interaction pour l'appariement
enum ModeAppariement {
  glisserDeposer, // Drag & Drop
  tracerLigne,    // Tracer une ligne entre les éléments
  selection,      // Sélectionner deux éléments
}

/// Élément individuel à apparier (peut être une image, un texte, etc.)
class ElementAppariement {
  final String id;
  final String texte;
  final String? imagePath;
  final String? soundPath;
  final Color? couleur;
  
  ElementAppariement({
    required this.id,
    required this.texte,
    this.imagePath,
    this.soundPath,
    this.couleur,
  });
}

/// Une paire d'éléments à apparier
class PaireAppariement {
  final ElementAppariement gauche;
  final ElementAppariement droite;
  
  PaireAppariement({
    required this.gauche,
    required this.droite,
  });
}

/// Modèle principal pour un exercice d'appariement interactif
class AppariementInteractifModel {
  final String id;
  final String titre;
  final String description;
  final AppariementType type;
  final NiveauDifficulte difficulte;
  final ModeAppariement mode;
  final List<PaireAppariement> paires;
  final int points;
  final String? mascotMessage;
  
  AppariementInteractifModel({
    required this.id,
    required this.titre,
    required this.description,
    required this.type,
    required this.difficulte,
    required this.mode,
    required this.paires,
    required this.points,
    this.mascotMessage,
  });
  
  /// Données d'exemple pour les exercices d'appariement
  static List<AppariementInteractifModel> getExercicesAppariement() {
    return [
      // Exercice 1: Formes et Couleurs - Niveau Facile
      AppariementInteractifModel(
        id: 'appariement_couleurs_formes_1',
        titre: 'Couleurs et Formes',
        description: 'Associe chaque forme à sa couleur',
        type: AppariementType.imageCouleur,
        difficulte: NiveauDifficulte.facile,
        mode: ModeAppariement.glisserDeposer,
        points: 10,
        mascotMessage: "Trouve la bonne couleur pour chaque forme!",
        paires: [
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'cercle_rouge',
              texte: 'Cercle Rouge',
              imagePath: ImageAssets.red_circle, // Use the asset constant
            ),
            droite: ElementAppariement(
              id: 'rouge',
              texte: 'Rouge',
              couleur: Colors.red,
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'carre_bleu',
              texte: 'Carré Bleu',
              imagePath: ImageAssets.blue_square, // Use the asset constant
            ),
            droite: ElementAppariement(
              id: 'bleu',
              texte: 'Bleu',
              couleur: Colors.blue,
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'triangle_vert',
              texte: 'Triangle Vert',
              imagePath: ImageAssets.green_triangle, // Use the asset constant
            ),
            droite: ElementAppariement(
              id: 'vert',
              texte: 'Vert',
              couleur: Colors.green,
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'rectangle_jaune',
              texte: 'Rectangle Jaune',
              imagePath: ImageAssets.yellow_rectangle, // Use the asset constant
            ),
            droite: ElementAppariement(
              id: 'jaune',
              texte: 'Jaune',
              couleur: Colors.yellow,
            ),
          ),
        ],
      ),
      
      // Nouvel exercice: Formes géométriques simples - Niveau Facile
      AppariementInteractifModel(
        id: 'appariement_formes_simples_1',
        titre: 'Formes Géométriques',
        description: 'Associe chaque forme à son nom',
        type: AppariementType.imageMot,
        difficulte: NiveauDifficulte.facile,
        mode: ModeAppariement.glisserDeposer,
        points: 10,
        mascotMessage: "Relie chaque forme à son nom!",
        paires: [
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'cercle_simple',
              texte: 'Cercle',
              imagePath: ImageAssets.red_circle, // Use the asset constant
            ),
            droite: ElementAppariement(
              id: 'nom_cercle',
              texte: 'Cercle',
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'carre_simple',
              texte: 'Carré',
              imagePath: ImageAssets.blue_square, // Use the asset constant
            ),
            droite: ElementAppariement(
              id: 'nom_carre',
              texte: 'Carré',
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'triangle_simple',
              texte: 'Triangle',
              imagePath: ImageAssets.green_triangle, // Use the asset constant
            ),
            droite: ElementAppariement(
              id: 'nom_triangle',
              texte: 'Triangle',
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'rectangle_simple',
              texte: 'Rectangle',
              imagePath: ImageAssets.yellow_rectangle, // Use the asset constant
            ),
            droite: ElementAppariement(
              id: 'nom_rectangle',
              texte: 'Rectangle',
            ),
          ),
        ],
      ),
      
      // Exercice 2: Animaux et leurs noms - Niveau Facile
      AppariementInteractifModel(
        id: 'appariement_animaux_1',
        titre: 'Les Animaux',
        description: 'Associe chaque animal à son nom',
        type: AppariementType.imageMot,
        difficulte: NiveauDifficulte.facile,
        mode: ModeAppariement.tracerLigne,
        points: 10,
        mascotMessage: "Relie chaque animal à son nom!",
        paires: [
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'chat',
              texte: 'Chat',
              imagePath: 'assets/images/exercises/cat.png',
            ),
            droite: ElementAppariement(
              id: 'nom_chat',
              texte: 'Chat',
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'chien',
              texte: 'Chien',
              imagePath: 'assets/images/exercises/dog.png',
            ),
            droite: ElementAppariement(
              id: 'nom_chien',
              texte: 'Chien',
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'elephant',
              texte: 'Éléphant',
              imagePath: 'assets/images/exercises/elephant.png',
            ),
            droite: ElementAppariement(
              id: 'nom_elephant',
              texte: 'Éléphant',
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'lapin',
              texte: 'Lapin',
              imagePath: 'assets/images/exercises/rabbit.png',
            ),
            droite: ElementAppariement(
              id: 'nom_lapin',
              texte: 'Lapin',
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'oiseau',
              texte: 'Oiseau',
              imagePath: 'assets/images/exercises/bird_.png',
            ),
            droite: ElementAppariement(
              id: 'nom_oiseau',
              texte: 'Oiseau',
            ),
          ),
        ],
      ),
      
      // Exercice 3: Fruits et leurs noms - Niveau Moyen
      AppariementInteractifModel(
        id: 'appariement_fruits_1',
        titre: 'Les Fruits',
        description: 'Associe chaque fruit à son nom',
        type: AppariementType.imageMot,
        difficulte: NiveauDifficulte.moyen,
        mode: ModeAppariement.selection,
        points: 15,
        mascotMessage: "Sélectionne un fruit puis son nom!",
        paires: [
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'pomme',
              texte: 'Pomme',
              imagePath: 'assets/images/exercises/apple.png',
            ),
            droite: ElementAppariement(
              id: 'nom_pomme',
              texte: 'Pomme',
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'banane',
              texte: 'Banane',
              imagePath: 'assets/images/exercises/banana.png',
            ),
            droite: ElementAppariement(
              id: 'nom_banane',
              texte: 'Banane',
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'fraise',
              texte: 'Fraise',
              imagePath: 'assets/images/exercises/strawberry.png',
            ),
            droite: ElementAppariement(
              id: 'nom_fraise',
              texte: 'Fraise',
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'cerise',
              texte: 'Cerise',
              imagePath: 'assets/images/exercises/colors/red_cherries.png',
            ),
            droite: ElementAppariement(
              id: 'nom_cerise',
              texte: 'Cerise',
            ),
          ),
        ],
      ),
      
      // Exercice 4: Objets de tailles différentes - Niveau Difficile
      AppariementInteractifModel(
        id: 'appariement_tailles_1',
        titre: 'Taille des Objets',
        description: 'Associe les objets de même taille',
        type: AppariementType.imageForme,
        difficulte: NiveauDifficulte.difficile,
        mode: ModeAppariement.glisserDeposer,
        points: 20,
        mascotMessage: "Trouve les objets qui ont la même taille!",
        paires: [
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'grand_vélo',
              texte: 'Grand vélo',
              imagePath: 'assets/images/exercises/size/bicycle.png',
            ),
            droite: ElementAppariement(
              id: 'grand_hippo',
              texte: 'Grand hippopotame',
              imagePath: 'assets/images/exercises/size/hippo.png',
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'moyen_chien',
              texte: 'Chien moyen',
              imagePath: 'assets/images/exercises/size/dog.png',
            ),
            droite: ElementAppariement(
              id: 'moyen_cerf',
              texte: 'Cerf moyen',
              imagePath: 'assets/images/exercises/size/deer.png',
            ),
          ),
          PaireAppariement(
            gauche: ElementAppariement(
              id: 'petit_stylo',
              texte: 'Petit stylo',
              imagePath: 'assets/images/exercises/size/pen.png',
            ),
            droite: ElementAppariement(
              id: 'petites_lunettes',
              texte: 'Petites lunettes',
              imagePath: 'assets/images/exercises/size/glasses.png',
            ),
          ),
        ],
      ),
    ];
  }
}