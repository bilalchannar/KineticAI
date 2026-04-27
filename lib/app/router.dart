import 'package:go_router/go_router.dart';
import 'package:kinetic_ai/screens/splash/splash_screen.dart';
import 'package:kinetic_ai/screens/main_screen.dart';
import 'package:kinetic_ai/screens/live_session/live_session_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/live',
      builder: (context, state) => const LiveSessionScreen(),
    ),
  ],
);