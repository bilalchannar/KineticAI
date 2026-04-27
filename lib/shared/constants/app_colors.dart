import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF0A0A12);
  static const Color surface = Color(0xFF1E1E2E);
  static const Color primary = Color(0xFF6C63FF);
  static const Color accent = Color(0xFF00D2FF);
  static const Color glass = Colors.white10;
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF3B3B98)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}