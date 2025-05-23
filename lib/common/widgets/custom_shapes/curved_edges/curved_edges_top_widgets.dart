import 'package:flutter/material.dart';
import 'package:kids_learning_app/common/widgets/custom_shapes/curved_edges/curved_edges_top.dart';

class CurvedEdgesWidgetTop extends StatelessWidget {
  const CurvedEdgesWidgetTop({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdgesTop(),
      child: child,
    );
  }
}