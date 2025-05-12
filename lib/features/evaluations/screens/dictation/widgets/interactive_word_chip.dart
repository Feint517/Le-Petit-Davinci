import 'package:flutter/material.dart';
import 'dart:math' as math;

class InteractiveWordChip extends StatefulWidget {
  final String text;
  final bool isSelected;
  final bool isInAnswer;
  final bool isPlayingAnimation;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final bool isCorrect;
  final bool isIncorrect;
  
  const InteractiveWordChip({
    super.key,
    required this.text,
    required this.isSelected,
    this.isInAnswer = false,
    this.isPlayingAnimation = false,
    required this.onTap,
    this.backgroundColor,
    this.isCorrect = false,
    this.isIncorrect = false,
  });

  @override
  State<InteractiveWordChip> createState() => _InteractiveWordChipState();
}

class _InteractiveWordChipState extends State<InteractiveWordChip> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _wiggleAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    // Scale animation
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );
    
    // Wiggle animation pour les mots incorrects
    _wiggleAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    
    // Si le mot est placé dans la zone de réponse, jouer l'animation
    if (widget.isInAnswer && widget.isPlayingAnimation) {
      _animationController.forward();
    }
    
    // Pour les mots incorrects, faire un wiggle
    if (widget.isIncorrect) {
      _animationController.repeat(reverse: true);
    }
  }
  
  @override
  void didUpdateWidget(InteractiveWordChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Si le widget passe à l'état "in answer", jouer l'animation
    if (widget.isInAnswer && !oldWidget.isInAnswer) {
      _animationController.reset();
      _animationController.forward();
    }
    
    // Si le widget passe à l'état incorrect, lancer le wiggle
    if (widget.isIncorrect && !oldWidget.isIncorrect) {
      _animationController.repeat(reverse: true);
    } else if (!widget.isIncorrect && oldWidget.isIncorrect) {
      _animationController.stop();
      _animationController.reset();
    }
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  // Obtenir une couleur de fond basée sur le texte
  Color _getWordColor() {
    if (widget.backgroundColor != null) {
      return widget.backgroundColor!;
    }
    
    final List<Color> colors = [
      const Color(0xFFFFD6E0),  // Light Pink
      const Color(0xFFFFEFB5),  // Light Yellow
      const Color(0xFFB5EAFF),  // Light Blue
      const Color(0xFFD1FFBD),  // Light Green
      const Color(0xFFE5CBFF),  // Light Purple
      const Color(0xFFFFD6C9),  // Light Orange
    ];
    
    // Utiliser le premier caractère du texte comme seed pour des couleurs cohérentes
    final int seed = widget.text.isNotEmpty ? widget.text.codeUnitAt(0) : 0;
    final random = math.Random(seed);
    return colors[random.nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    // Ne pas afficher le chip s'il est sélectionné et pas dans la zone de réponse
    if (widget.isSelected && !widget.isInAnswer) {
      return const SizedBox.shrink();
    }
    
    // Couleur de fond basée sur l'état
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    
    if (widget.isCorrect) {
      backgroundColor = const Color(0xFFD1FFBD).withOpacity(0.8);
      borderColor = Colors.green;
      textColor = Colors.green.shade800;
    } else if (widget.isIncorrect) {
      backgroundColor = const Color(0xFFFFD6E0).withOpacity(0.8);
      borderColor = Colors.red;
      textColor = Colors.red.shade800;
    } else {
      backgroundColor = widget.isInAnswer 
          ? _getWordColor() 
          : _getWordColor().withOpacity(0.6);
      
      borderColor = widget.isInAnswer
          ? Colors.black.withOpacity(0.5)
          : Colors.black.withOpacity(0.2);
          
      textColor = Colors.black.withOpacity(widget.isInAnswer ? 1.0 : 0.7);
    }
    
    return AnimatedBuilder(
      animation: Listenable.merge([_scaleAnimation, _wiggleAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: widget.isInAnswer ? _scaleAnimation.value : 1.0,
          child: Transform.rotate(
            angle: widget.isIncorrect ? _wiggleAnimation.value : 0,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                margin: const EdgeInsets.only(right: 6, bottom: 6),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: borderColor,
                    width: widget.isInAnswer ? 2.0 : 1.0,
                  ),
                  boxShadow: widget.isInAnswer ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ] : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icône si nécessaire
                    if (widget.isCorrect)
                      const Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 16,
                        ),
                      )
                    else if (widget.isIncorrect)
                      const Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 16,
                        ),
                      ),
                    
                    // Texte du mot
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontFamily: 'Bricolage Grotesque',
                        fontSize: 14,
                        fontWeight: widget.isInAnswer ? FontWeight.w600 : FontWeight.w500,
                        color: textColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}