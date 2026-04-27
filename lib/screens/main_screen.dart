import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kinetic_ai/screens/dashboard/dashboard_screen.dart';
import 'package:kinetic_ai/screens/route_map/route_map_screen.dart';
import 'package:kinetic_ai/screens/history/history_screen.dart';
import 'package:kinetic_ai/screens/goals/goals_screen.dart';
import 'package:kinetic_ai/screens/settings/settings_screen.dart';

final navigationIndexProvider = StateProvider<int>((ref) => 0);

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navigationIndexProvider);

    final List<Widget> screens = [
      const DashboardScreen(),
      const RouteMapScreen(),
      const HistoryScreen(),
      const GoalsScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: _buildBottomNav(ref, index),
    );
  }

  Widget _buildBottomNav(WidgetRef ref, int currentIndex) {
    return Container(
      height: 85,
      decoration: const BoxDecoration(
        color: Color(0xFF0F0F1A),
        border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(ref, 0, Icons.dashboard_rounded, 'Home', currentIndex == 0),
          _buildNavItem(ref, 1, Icons.map_rounded, 'Route', currentIndex == 1),
          _buildNavItem(ref, 2, Icons.analytics_rounded, 'Stats', currentIndex == 2),
          _buildNavItem(ref, 3, Icons.emoji_events_rounded, 'Goals', currentIndex == 3),
          _buildNavItem(ref, 4, Icons.settings_rounded, 'Settings', currentIndex == 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(WidgetRef ref, int index, IconData icon, String label, bool isSelected) {
    return GestureDetector(
      onTap: () => ref.read(navigationIndexProvider.notifier).state = index,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF6C63FF) : Colors.white30,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF6C63FF) : Colors.white30,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
