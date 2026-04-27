import 'package:flutter/material.dart';

class AnimatedRing extends StatefulWidget {
  final double progress;
  final Color color;
  final double size;

  const AnimatedRing({
    super.key,
    required this.progress,
    required this.color,
    this.size = 100,
  });

  @override
  State<AnimatedRing> createState() => _AnimatedRingState();
}

class _AnimatedRingState extends State<AnimatedRing> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(begin: oldWidget.progress, end: widget.progress).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
      _controller.reset();
      _controller.forward();
    }
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
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CircularProgressIndicator(
            value: _animation.value,
            strokeWidth: 10,
            backgroundColor: widget.color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(widget.color),
            strokeCap: StrokeCap.round,
          ),
        );
      },
    );
  }
}