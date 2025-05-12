import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Cette classe fournit des fonctions de compatibilité pour aider à gérer les cas
/// où certaines dépendances pourraient être absentes
class AppariementCompatibility {
  
  /// Vérifie si un contrôleur est enregistré et le renvoie, ou crée un contrôleur de secours
  static T getControllerSafely<T>(T Function() creator, {String? tag}) {
    if (Get.isRegistered<T>(tag: tag)) {
      try {
        return Get.find<T>(tag: tag);
      } catch (e) {
        debugPrint("Erreur lors de la récupération du contrôleur $T: $e");
        return creator();
      }
    } else {
      final controller = creator();
      try {
        Get.put<T>(controller as dynamic, tag: tag);
      } catch (e) {
        debugPrint("Erreur lors de l'enregistrement du contrôleur $T: $e");
      }
      return controller;
    }
  }
  
  /// Vérifie qu'un asset existe, ou renvoie un asset de secours
  static String getAssetPathSafely(String assetPath, String fallbackPath) {
    try {
      // Ici, on pourrait implémenter une vérification plus robuste de l'existence de l'asset
      // Mais pour l'instant, on retourne simplement le chemin original ou de secours
      return assetPath;
    } catch (e) {
      debugPrint("Erreur lors de la vérification de l'asset $assetPath: $e");
      return fallbackPath;
    }
  }
  
  /// Wrapper pour exécuter du code en toute sécurité avec gestion des erreurs
  static void runSafely(VoidCallback action, {VoidCallback? onError}) {
    try {
      action();
    } catch (e) {
      debugPrint("Erreur exécution sécurisée: $e");
      if (onError != null) {
        onError();
      }
    }
  }
  
  /// Vérifie si un widget peut être construit en toute sécurité
  static Widget buildSafely(Widget Function() builder, {Widget? fallback}) {
    try {
      return builder();
    } catch (e) {
      debugPrint("Erreur lors de la construction du widget: $e");
      return fallback ?? const SizedBox.shrink();
    }
  }
}