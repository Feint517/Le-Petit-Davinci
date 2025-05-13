import 'package:flutter/material.dart';

class AnimatedAudioButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isPlaying;
  final int repeatCount;

  const AnimatedAudioButton({
    Key? key,
    required this.onTap,
    required this.isPlaying,
    this.repeatCount = 0,
  }) : super(key: key);

  @override
  State<AnimatedAudioButton> createState() => _AnimatedAudioButtonState();
}

class _AnimatedAudioButtonState extends State<AnimatedAudioButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _colorAnimation = ColorTween(
      begin: Colors.purple,
      end: Colors.deepPurple,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Si l'animation est en cours, démarrer l'animation
    if (widget.isPlaying) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(AnimatedAudioButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Vérifier si l'état de lecture a changé
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _animationController.repeat(reverse: true);
      } else {
        _animationController.stop();
        _animationController.reset();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(30),
            child: Ink(
              decoration: BoxDecoration(
                color:
                    widget.isPlaying
                        ? const Color(0xFFF0E5FF)
                        : const Color(0xFFF7E5FF),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color:
                        widget.isPlaying
                            ? Colors.deepPurple.withValues(alpha: 0.4)
                            : Colors.purple.withValues(alpha: 0.3),
                    blurRadius: widget.isPlaying ? 8 : 5,
                    offset: const Offset(0, 2),
                    spreadRadius: widget.isPlaying ? 1 : 0,
                  ),
                ],
              ),
              child: Transform.scale(
                scale: widget.isPlaying ? _scaleAnimation.value : 1.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Icône principale
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        widget.isPlaying
                            ? Icons.volume_up_rounded
                            : Icons.headphones_rounded,
                        color:
                            widget.isPlaying
                                ? _colorAnimation.value
                                : Colors.purple,
                        size: 30,
                      ),
                    ),

                    // Indicateurs d'ondes sonores (visibles uniquement pendant la lecture)
                    if (widget.isPlaying)
                      ...List.generate(3, (index) {
                        final delay = index * 0.2;
                        final opacity =
                            (1.0 - _animationController.value + delay) % 1.0;

                        return Positioned.fill(
                          child: Opacity(
                            opacity: opacity,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.deepPurple.withValues(
                                    alpha: 0.7 * opacity,
                                  ),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),

                    // Badge de compteur
                    if (widget.repeatCount > 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            widget.repeatCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
