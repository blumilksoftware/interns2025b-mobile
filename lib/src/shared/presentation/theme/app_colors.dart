import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF025F60);
  static const backgroundLight = Colors.white;
  static const fieldBackground = Color(0xFFEAEAEA);

  static const text = Color(0xFF0A8270);
  static const textDisabled = Color(0xFF3E4043);
  static const textLight = Color(0xFFF1F7F6);
  static const textLightSecondary = Color(0xB3FFFFFF);
  static const textSecondary = Color(0xFF036061);

  static const primary = Color(0xFF025F60);
  static const primaryHover = Color(0xFF057475);

  static const secondary = Color(0xFF151515);
  static const secondaryHover = Color(0xFF272525);

  static const primaryGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0],
    colors: [Color(0xFF093637), Color(0xFF025F60)],
  );
}
