import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 80, color: Colors.cyanAccent),
          const SizedBox(height: 48),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, height: 1.1),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(color: Colors.white54, fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}