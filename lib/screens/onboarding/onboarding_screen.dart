import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kinetic_ai/shared/constants/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'PRECISION\nTRACKING',
      subtitle: 'Advanced biomechanics analysis using built-in sensors.',
      icon: Icons.track_changes_rounded,
    ),
    OnboardingData(
      title: 'AI POWERED\nCOACHING',
      subtitle: 'Real-time form correction driven by Gemini AI.',
      icon: Icons.auto_awesome_rounded,
    ),
    OnboardingData(
      title: 'RECOVERY\nMONITORING',
      subtitle: 'Acoustic breathing analysis to optimize your rest.',
      icon: Icons.air_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: (idx) => setState(() => _currentPage = idx),
            itemBuilder: (context, idx) => _buildPage(_pages[idx]),
          ),
          Positioned(
            bottom: 60,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(_pages.length, (idx) => _buildDot(idx)),
                ),
                _buildActionButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(data.icon, size: 80, color: AppColors.accent),
          const SizedBox(height: 48),
          Text(
            data.title,
            style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900, height: 1.1),
          ),
          const SizedBox(height: 24),
          Text(
            data.subtitle,
            style: const TextStyle(color: Colors.white54, fontSize: 18, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      height: 4,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColors.accent : Colors.white24,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildActionButton() {
    bool isLast = _currentPage == _pages.length - 1;
    return GestureDetector(
      onTap: () {
        if (isLast) {
          context.go('/login');
        } else {
          _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
        child: Icon(isLast ? Icons.check : Icons.arrow_forward, color: Colors.white),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String subtitle;
  final IconData icon;
  OnboardingData({required this.title, required this.subtitle, required this.icon});
}