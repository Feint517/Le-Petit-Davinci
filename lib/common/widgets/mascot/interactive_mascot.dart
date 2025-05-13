import 'package:flutter/material.dart';
import 'package:kids_learning_app/common/widgets/mascot/mascot_state.dart';
import 'dart:math' as math;

/// Widget de mascotte interactive qui réagit aux interactions utilisateur
class InteractiveMascot extends StatefulWidget {
  final MascotType mascotType;
  final MascotState initialState;
  final double size;
  final VoidCallback? onTap;
  final bool enableAnimation;

  const InteractiveMascot({
    super.key,
    required this.mascotType,
    this.initialState = MascotState.idle,
    this.size = 120.0,
    this.onTap,
    this.enableAnimation = true,
  });

  @override
  State<InteractiveMascot> createState() => _InteractiveMascotState();
}

class _InteractiveMascotState extends State<InteractiveMascot> with TickerProviderStateMixin {
  late MascotState _currentState;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;
  late AnimationController _wiggleController;
  late Animation<double> _wiggleAnimation;
  
  @override
  void initState() {
    super.initState();
    _currentState = widget.initialState;
    
    // Animation de rebondissement
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _bounceAnimation = Tween<double>(begin: 0, end: 10)
      .animate(CurvedAnimation(
        parent: _bounceController,
        curve: Curves.elasticOut,
      ));
    
    // Animation de balancement
    _wiggleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    
    _wiggleAnimation = Tween<double>(begin: -0.05, end: 0.05)
      .animate(CurvedAnimation(
        parent: _wiggleController,
        curve: Curves.easeInOut,
      ));
    
    _wiggleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _wiggleController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _wiggleController.forward();
      }
    });
    
    // Jouer l'animation d'entrée si activée
    if (widget.enableAnimation) {
      _bounceController.forward();
      
      // Démarrer l'animation de balancement pour certains états
      if (_currentState == MascotState.happy || 
          _currentState == MascotState.celebrating) {
        _wiggleController.forward();
      }
    }
  }
  
  @override
  void didUpdateWidget(InteractiveMascot oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Si l'état initial a changé, mettre à jour l'état actuel
    if (widget.initialState != oldWidget.initialState) {
      setState(() {
        _currentState = widget.initialState;
      });
      
      // Déclencher une animation en fonction du nouvel état
      if (widget.enableAnimation) {
        _triggerAnimationForState(widget.initialState);
      }
    }
  }
  
  void _triggerAnimationForState(MascotState state) {
    // Réinitialiser les animations
    _bounceController.reset();
    
    // Arrêter le balancement sauf pour les états joyeux
    if (state != MascotState.happy && state != MascotState.celebrating) {
      _wiggleController.reset();
    }
    
    // Animer en fonction de l'état
    switch (state) {
      case MascotState.happy:
      case MascotState.celebrating:
        _bounceController.forward();
        _wiggleController.forward();
        break;
        
      case MascotState.sad:
        // Animation plus lente pour la tristesse
        _bounceController.duration = const Duration(milliseconds: 800);
        _bounceController.forward();
        break;
        
      case MascotState.question:
      case MascotState.thinking:
        _bounceController.duration = const Duration(milliseconds: 500);
        _bounceController.forward();
        break;
        
      default:
        _bounceController.forward();
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _wiggleController.dispose();
    super.dispose();
  }

  void changeState(MascotState newState) {
    setState(() {
      _currentState = newState;
    });
    
    if (widget.enableAnimation) {
      _triggerAnimationForState(newState);
    }
  }

  String _getMascotImagePath() {
    String mascotFolder;
    
    switch (widget.mascotType) {
      case MascotType.elephant:
        mascotFolder = 'elephant';
        break;
      case MascotType.owl:
        mascotFolder = 'owl';
        break;
      case MascotType.panda:
        mascotFolder = 'panda';
        break;
    }
    
    String stateImage;
    
    switch (_currentState) {
      case MascotState.happy:
      case MascotState.celebrating:
        stateImage = 'happy';
        break;
      case MascotState.sad:
        stateImage = 'sad';
        break;
      case MascotState.question:
      case MascotState.thinking:
        stateImage = 'question';
        break;
      case MascotState.idle:
      default:
        stateImage = 'happy';
        break;
    }
    
    return 'assets/images/mascots/$mascotFolder/${stateImage}_$mascotFolder.png';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        } else {
          // Changement aléatoire d'état lors du tap si aucun callback n'est fourni
          final states = MascotState.values;
          final randomIndex = DateTime.now().millisecondsSinceEpoch % states.length;
          changeState(states[randomIndex]);
        }
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([_bounceAnimation, _wiggleAnimation]),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, -_bounceAnimation.value),
            child: Transform.rotate(
              angle: _currentState == MascotState.happy || _currentState == MascotState.celebrating
                  ? _wiggleAnimation.value
                  : 0,
              child: child,
            ),
          );
        },
        child: Stack(
          children: [
            Image.asset(
              _getMascotImagePath(),
              height: widget.size,
              width: widget.size,
            ),
            if (_currentState == MascotState.celebrating)
              _buildConfetti(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildConfetti() {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: CustomPaint(
        painter: ConfettiPainter(animation: _wiggleController),
      ),
    );
  }
}

/// Peintre de confettis pour l'état de célébration
class ConfettiPainter extends CustomPainter {
  final Animation animation;
  final List<Confetti> confetti = [];
  
  ConfettiPainter({required this.animation}) : super(repaint: animation) {
    if (confetti.isEmpty) {
      for (int i = 0; i < 20; i++) {
        confetti.add(Confetti());
      }
    }
  }
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    
    for (var c in confetti) {
      paint.color = c.color;
      
      // Mettre à jour la position des confettis
      c.update(animation.value, size);
      
      // Dessiner les confettis
      canvas.drawRect(
        Rect.fromLTWH(c.position.dx, c.position.dy, c.size, c.size), 
        paint
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Classe représentant un confetti
class Confetti {
  late Offset position;
  late double size;
  late Color color;
  late double speed;
  
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
  ];
  
  Confetti() {
    _init();
  }
  
  void _init() {
    final random = math.Random();
    position = Offset(
      random.nextDouble() * 120,
      random.nextDouble() * 10 - 10
    );
    size = 3 + random.nextDouble() * 5;
    color = colors[random.nextInt(colors.length)];
    speed = 0.5 + random.nextDouble() * 2;
  }
  
  void update(double delta, Size containerSize) {
    position = Offset(
      position.dx + (math.Random().nextDouble() - 0.5) * 2,
      position.dy + speed
    );
    
    // Réinitialiser si le confetti sort de l'écran
    if (position.dy > containerSize.height) {
      position = Offset(
        math.Random().nextDouble() * containerSize.width,
        -size
      );
    }
  }
}