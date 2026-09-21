import 'package:flutter/material.dart';

const backgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF4A148C),
    Color(0xFF6A1B9A),
    Color(0xFF8E24AA),
    Color(0xFFAB47BC),
  ],
);
class AppColors {
  static const Color primaryColor = Color(0xFF4A148C);
  static const Color secondaryColor = Color(0xFF6A1B9A);
  static const Color accentColor = Color(0xFF8E24AA);
  static const Color backgroundColor = Color(0xFFAB47BC);
  static const Color textColor = Colors.white;
}