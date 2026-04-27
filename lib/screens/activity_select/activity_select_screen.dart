import 'package:flutter/material.dart';
import 'package:kinetic_ai/data/models/activity_type.dart';
import 'package:kinetic_ai/screens/activity_select/widgets/activity_card.dart';

class ActivitySelectScreen extends StatelessWidget {
  const ActivitySelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      appBar: AppBar(
        title: const Text('SELECT ACTIVITY', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        backgroundColor: Colors.transparent,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          ActivityCard(type: ActivityType.walking, onTap: () => Navigator.pop(context)),
          ActivityCard(type: ActivityType.running, onTap: () => Navigator.pop(context)),
          ActivityCard(type: ActivityType.hiking, onTap: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}