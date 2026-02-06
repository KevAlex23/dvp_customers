import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Colors.purple,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.cyan,
    primary: Colors.purple,
    secondary: Colors.cyan,
    surface: Colors.white,
    onSurface: Colors.black,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    error: Colors.redAccent,
    
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black.withValues(alpha: 0.7),
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black.withValues(alpha: 0.6),
    ),
  ),
);