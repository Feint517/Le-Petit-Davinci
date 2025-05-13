import 'package:flutter/material.dart';

class InteractiveOptionItem extends StatefulWidget {
  final String option;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color color;
  final String? imagePath;

  const InteractiveOptionItem({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
    required this.color,
    this.imagePath,
  });

  @override
  State<InteractiveOptionItem> createState() => _InteractiveOptionItemState();
}

class _InteractiveOptionItemState extends State<InteractiveOptionItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (widget.isSelected) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(InteractiveOptionItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _animationController.forward();
      } else {
        _animationController.reverse();
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: GestureDetector(
          onTapDown:
              widget.onTap == null
                  ? null
                  : (_) {
                    setState(() {
                      _isPressed = true;
                    });
                    _animationController.forward();
                  },
          onTapUp:
              widget.onTap == null
                  ? null
                  : (_) {
                    setState(() {
                      _isPressed = false;
                    });
                    if (!widget.isSelected) {
                      _animationController.reverse();
                    }
                  },
          onTapCancel:
              widget.onTap == null
                  ? null
                  : () {
                    setState(() {
                      _isPressed = false;
                    });
                    if (!widget.isSelected) {
                      _animationController.reverse();
                    }
                  },
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              color:
                  widget.isSelected
                      ? widget.color
                      : (_isPressed
                          ? widget.color.withValues(alpha: 0.7)
                          : widget.color.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.isSelected ? Colors.deepPurple : widget.color,
                width: widget.isSelected ? 2 : 1,
              ),
              boxShadow:
                  widget.isSelected
                      ? [
                        BoxShadow(
                          color: widget.color.withValues(alpha: 0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                      : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onTap,
                  splashColor: widget.color.withValues(alpha: 0.5),
                  highlightColor: widget.color.withValues(alpha: 0.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        // Selection indicator
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                widget.isSelected
                                    ? Colors.deepPurple
                                    : Colors.white,
                            border: Border.all(
                              color:
                                  widget.isSelected
                                      ? Colors.deepPurple
                                      : Colors.grey.shade400,
                              width: 2,
                            ),
                          ),
                          child:
                              widget.isSelected
                                  ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  )
                                  : null,
                        ),
                        const SizedBox(width: 12),

                        // Option image if available
                        if (widget.imagePath != null) ...[
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.asset(
                              widget.imagePath!,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],

                        // Option text
                        Expanded(
                          child: Text(
                            widget.option,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight:
                                  widget.isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
