import 'package:flutter/material.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';

/// Versions sécurisées des widgets standard qui gèrent les erreurs
/// et offrent des mécanismes de fallback pour éviter les crashs

/// Une version de Image.asset qui gère les erreurs de chargement d'image
class SafeImageAsset extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? fallbackWidget;

  const SafeImageAsset({
    Key? key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.fallbackWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Erreur chargement image $imagePath: $error');
        return fallbackWidget ??
            Container(
              width: width,
              height: height,
              color: AppColors.grey.withValues(alpha: 0.1),
              child: Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.grey.withValues(alpha: 0.5),
                  size: width != null ? width! * 0.5 : 24,
                ),
              ),
            );
      },
    );
  }
}

/// Un conteneur avec des contraintes qui évite les dimensions négatives
class SafeContainer extends StatelessWidget {
  final Widget? child;
  final BoxDecoration? decoration;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;

  const SafeContainer({
    Key? key,
    this.child,
    this.decoration,
    this.color,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // S'assurer que width et height ne sont jamais négatifs
    final safeWidth = width != null && width! < 0 ? 0.0 : width;
    final safeHeight = height != null && height! < 0 ? 0.0 : height;

    return Container(
      decoration: decoration,
      color: color,
      padding: padding,
      margin: margin,
      alignment: alignment,
      constraints: BoxConstraints(
        minWidth: 0,
        minHeight: 0,
        maxWidth: safeWidth ?? double.infinity,
        maxHeight: safeHeight ?? double.infinity,
      ),
      child: child,
    );
  }
}

/// Un bouton avec une gestion d'erreur intégrée
class SafeButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;

  const SafeButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          onPressed != null
              ? () {
                try {
                  onPressed!();
                } catch (e) {
                  debugPrint('Erreur lors du clic sur le bouton: $e');
                }
              }
              : null,
      style: style,
      child: child,
    );
  }
}
