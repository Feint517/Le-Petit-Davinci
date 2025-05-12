# Solution pour l'audio dans la fonctionnalité de dictée interactive

## Problème actuel
La fonctionnalité de dictée interactive utilise actuellement des fichiers audio génériques (comme `winner.mp3`) au lieu de vrais enregistrements vocaux des phrases à dicter. Cela ne permet pas aux utilisateurs d'entendre les phrases qu'ils doivent composer.

## Solution à court terme
La solution temporaire mise en place consiste à:
1. Utiliser des sons existants dans les assets (`assets/sfx/winner.mp3`) pour simuler la lecture audio
2. Améliorer la robustesse du code de lecture audio pour éviter les plantages
3. Ajouter des logs détaillés pour faciliter le débogage

## Solution à long terme
Pour une véritable expérience de dictée, nous recommandons:

### Option 1: Utiliser des fichiers audio préenregistrés
1. Créer un dossier `assets/sfx/dictee/` 
2. Y placer des fichiers audio préenregistrés pour chaque phrase:
   - `dictee_f1.mp3` - "Le chat joue avec une balle rouge."
   - `dictee_f2.mp3` - "Ma soeur va à l'école tous les jours."
   - etc.
3. Mettre à jour les chemins dans la classe `DicteeInteractiveModel`:
   ```dart
   audioPath: "assets/sfx/dictee/dictee_f1.mp3"
   ```

### Option 2: Intégration de la synthèse vocale (TTS)
Pour une solution plus flexible:

1. Ajouter la dépendance `flutter_tts` au projet:
   ```yaml
   dependencies:
     flutter_tts: ^3.8.3
   ```

2. Implémenter une classe `DicteeTtsService`:
   ```dart
   import 'package:flutter_tts/flutter_tts.dart';
   
   class DicteeTtsService {
     final FlutterTts flutterTts = FlutterTts();
     
     DicteeTtsService() {
       _init();
     }
     
     Future<void> _init() async {
       await flutterTts.setLanguage("fr-FR");
       await flutterTts.setSpeechRate(0.5); // Parler lentement pour les dictées
       await flutterTts.setVolume(1.0);
     }
     
     Future<void> speak(String text) async {
       await flutterTts.speak(text);
     }
     
     Future<void> stop() async {
       await flutterTts.stop();
     }
   }
   ```

3. Intégrer ce service dans le contrôleur de dictée:
   ```dart
   // Dans DicteeInteractiveController
   final DicteeTtsService ttsService = DicteeTtsService();
   
   void playAudio() async {
     isAudioPlaying.value = true;
     _mascotController.startThinking();
     
     await ttsService.speak(currentDictee.fullPhrase);
     
     // ... reste du code ...
   }
   ```

### Option 3: Génération locale de fichiers audio
Pour préparer les fichiers audio à l'avance mais conserver de la flexibilité:

1. Utiliser la classe `DicteeAudioGenerator` fournie pour générer des fichiers audio
2. Les sauvegarder dans le stockage local de l'application
3. Les charger avec `audioPlayer.setFilePath()`

Cette option combine l'efficacité des fichiers préenregistrés avec la flexibilité du TTS.

## Mise en œuvre recommandée
Nous recommandons l'option 2 (TTS) car elle offre:
- Une flexibilité totale pour modifier les textes des dictées
- Pas besoin de gérer des fichiers audio supplémentaires
- Possibilité de personnaliser la voix, la vitesse, etc.

Pour l'intégrer, suivez les étapes de l'option 2 et mettez à jour le contrôleur de dictée en conséquence.