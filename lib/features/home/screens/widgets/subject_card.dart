import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kids_learning_app/utils/constants/colors.dart';
import 'package:kids_learning_app/utils/constants/sizes.dart';

class SubjectCard extends StatefulWidget {
  final String title;
  final String total;
  final String imagePath;
  final double progress;
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.title,
    required this.total,
    required this.imagePath,
    required this.progress,
    required this.onTap,
  });

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Get a gradient color based on the progress
  List<Color> _getGradientColors() {
    if (widget.progress > 0.7) {
      return [
        AppColors.primaryDeep.withOpacity(0.8),
        AppColors.primaryDeep.withOpacity(0.6),
      ];
    } else if (widget.progress > 0.4) {
      return [
        AppColors.secondary.withOpacity(0.8),
        AppColors.secondary.withOpacity(0.6),
      ];
    } else {
      return [
        AppColors.accent.withOpacity(0.8),
        AppColors.accent.withOpacity(0.6),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the progress percentage as an integer
    final progressPercent = (widget.progress * 100).toInt();
    
    // Generate colors for the gradient background
    final gradientColors = _getGradientColors();

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering = true;
          _controller.forward();
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
          _controller.reverse();
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 180,
                height: 220,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: _isHovering
                          ? AppColors.primaryDeep.withOpacity(0.3)
                          : AppColors.black.withOpacity(0.2),
                      blurRadius: _isHovering ? 15 : 10,
                      offset: _isHovering 
                          ? const Offset(0, 5)
                          : const Offset(0, 1),
                      spreadRadius: _isHovering ? 1 : 0,
                    ),
                  ],
                ),
                child: ClipRRect(  // Added ClipRRect to properly clip all contents
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      // Background decoration - positioned within bounds
                      Positioned(
                        right: 0, // Changed from -20 to 0
                        top: 0,   // Changed from -20 to 0
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: gradientColors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(100),
                            ),
                          ),
                          child: Opacity(opacity: 0.3),
                        ),
                      ),
                      
                      // Main content
                      Padding(
                        padding: const EdgeInsets.all(AppSizes.md),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and image row
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black.withOpacity(0.1),
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: SvgPicture.asset(
                                    widget.imagePath,
                                    height: 35,
                                    width: 35,
                                  ),
                                ),
                                const Spacer(),
                                // Status pill showing if subject is active
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: widget.progress > 0
                                        ? const Color(0xFFE2F5E9)
                                        : Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    widget.progress > 0 ? 'En cours' : 'Nouveau',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: widget.progress > 0
                                          ? const Color(0xFF34C759)
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const Gap(20),
                            
                            // Title with more emphasis
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A1A),
                                fontFamily: 'BricolageGrotesque',
                              ),
                            ),
                            
                            const Gap(8),
                            
                            // Materials count
                            Text(
                              widget.total,
                              style: const TextStyle(
                                color: Color(0xFF6B6B6B),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            
                            const Gap(24),
                            
                            // Progress section
                            Row(
                              children: [
                                const Text(
                                  'Progression',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF424242),
                                  ),
                                ),
                                const Spacer(),
                                // Progress percentage pill
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: gradientColors,
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    '$progressPercent%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const Gap(8),
                            
                            // Enhanced progress bar with animation
                            TweenAnimationBuilder<double>(
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeInOut,
                              tween: Tween<double>(
                                begin: 0,
                                end: widget.progress,
                              ),
                              builder: (context, value, _) => Stack(
                                children: [
                                  // Background
                                  Container(
                                    height: 12,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Colors.grey[300]!,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  // Foreground (progress)
                                  Container(
                                    height: 12,
                                    width: value * (180 - (AppSizes.md * 2)),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: gradientColors,
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: gradientColors[0].withOpacity(0.3),
                                          blurRadius: 3,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}