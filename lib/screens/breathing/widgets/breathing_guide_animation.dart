import 'package:flutter/material.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class BreathingGuideAnimation extends StatefulWidget {
  final bool isInhale;

  const BreathingGuideAnimation({super.key, required this.isInhale});

  @override
  State<BreathingGuideAnimation> createState() => _BreathingGuideAnimationState();
}

class _BreathingGuideAnimationState extends State<BreathingGuideAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accent.withOpacity(0.5),
                  AppColors.accent.withOpacity(0.1),
                ],
              ),
              boxShadow: [
                BoxShadow(color: AppColors.accent.withOpacity(0.2), blurRadius: 40, spreadRadius: 10),
              ],
            ),
            child: Center(
              child: Text(
                widget.isInhale ? 'INHALE' : 'EXHALE',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
              ),
            ),
          ),
        );
      },
    );
  }
}