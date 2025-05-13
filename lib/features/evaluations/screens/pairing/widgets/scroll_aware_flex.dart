import 'package:flutter/material.dart';

/// Un widget qui affiche ses enfants soit dans une Row, soit dans une Column,
/// avec une possibilité de défilement si l'espace est insuffisant.
/// 
/// Ce widget est utile pour éviter les problèmes de dépassement (overflow) dans les layouts.
class ScrollAwareFlex extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Axis direction;
  final MainAxisSize mainAxisSize;
  final bool scrollable;
  
  const ScrollAwareFlex({
    Key? key,
    required this.children,
    this.direction = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.scrollable = true,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final flexWidget = direction == Axis.horizontal
        ? Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: children,
          )
        : Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: children,
          );
    
    if (!scrollable) {
      return flexWidget;
    }
    
    return direction == Axis.horizontal
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: flexWidget,
          )
        : SingleChildScrollView(
            child: flexWidget,
          );
  }
}