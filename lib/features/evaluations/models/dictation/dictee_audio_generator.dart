import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'dictee_interactive_model.dart';

/// Classe utilitaire pour générer des fichiers audio pour les dictées
class DicteeAudioGenerator {
  final FlutterTts flutterTts = FlutterTts();
  
  DicteeAudioGenerator() {
    _initTts();
  }
  
  Future<void> _initTts() async {
    await flutterTts.setLanguage("fr-FR");
    await flutterTts.setSpeechRate(0.5); // Parler lentement pour les dictées
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }
  
  /// Génère des fichiers audio pour toutes les dictées
  Future<void> generateAllAudioFiles() async {
    final dictees = DicteeInteractiveModel.getSampleDictees();
    
    for (final dictee in dictees) {
      await generateAudioFile(dictee);
    }
  }
  
  /// Génère un fichier audio pour une dictée spécifique
  Future<String> generateAudioFile(DicteeInteractiveModel dictee) async {
    final String phrase = dictee.fullPhrase;
    final String id = dictee.id;
    
    // Créer le dossier s'il n'existe pas encore
    final directory = await getApplicationDocumentsDirectory();
    final String audioDir = '${directory.path}/dictee_audio';
    
    final Directory audioDirObj = Directory(audioDir);
    if (!await audioDirObj.exists()) {
      await audioDirObj.create(recursive: true);
    }
    
    final String filePath = '$audioDir/$id.mp3';
    
    try {
      await flutterTts.synthesizeToFile(phrase, filePath);
      debugPrint('Fichier audio généré: $filePath');
      return filePath;
    } catch (e) {
      debugPrint('Erreur lors de la génération du fichier audio: $e');
      return '';
    }
  }
  
  /// Remplace les chemins d'audio dans les modèles par les chemins générés
  static Map<String, String> getUpdatedAudioPaths() {
    return {
      'dictee_f1': 'assets/sfx/dictee/dictee_f1.mp3',
      'dictee_f2': 'assets/sfx/dictee/dictee_f2.mp3',
      'dictee_m1': 'assets/sfx/dictee/dictee_m1.mp3',
      'dictee_m2': 'assets/sfx/dictee/dictee_m2.mp3',
      'dictee_d1': 'assets/sfx/dictee/dictee_d1.mp3',
      'dictee_d2': 'assets/sfx/dictee/dictee_d2.mp3',
    };
  }
}