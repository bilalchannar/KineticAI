import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';
import 'package:kinetic_ai/shared/widgets/section_header.dart';
import 'package:kinetic_ai/screens/coaching/widgets/coach_feed_tile.dart';
import 'package:kinetic_ai/screens/coaching/widgets/overtraining_alert.dart';
import 'package:kinetic_ai/screens/coaching/widgets/goal_progress_card.dart';
import 'package:kinetic_ai/data/models/coaching_model.dart';

class CoachingScreen extends ConsumerWidget {
  const CoachingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: AppColors.background,
            floating: true,
            title: Text(
              'AI COACH',
              style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OvertrainingAlert(riskScore: 0.8), 
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GoalProgressCard(progress: 0.65),
                  ),
                  const SizedBox(height: 32),
                  const SectionHeader(title: 'LIVE COACHING FEED'),
                  ListView.separated(
                    padding: const EdgeInsets.all(20),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return CoachFeedTile(
                        tip: CoachingModel(
                          message: 'Your left stride shows higher impact than your right. Try to land softer on your left heel.',
                          category: 'Gait Symmetry',
                          priority: CoachingPriority.high,
                          timestamp: DateTime.now(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}