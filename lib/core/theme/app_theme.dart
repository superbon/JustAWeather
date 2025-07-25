/*
 * @Author: Bon Ryan
 * @Created: 2025-07-25
 * @Page: app_theme
 * @Description: This file contains the AppTheme class for managing the application's theme.
 * It defines the primary color, accent color, and text theme used throughout the app.
 * It is used to provide a consistent look and feel across the application.
 * It is part of the core theme layer and is used in the main.dart file to set
 * the theme for the entire app.
 * 
 * @usage:
 * final appTheme = AppTheme();
 */


import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: Colors.teal,
    secondary: Colors.orangeAccent,
    surface: Colors.white
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.black54),
    border: InputBorder.none,
    // add other customizations as needed
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.teal,
  scaffoldBackgroundColor: const Color(0xFF101518),
  colorScheme: ColorScheme.dark(
    primary: Colors.teal,
    secondary: Colors.orangeAccent,
    surface: Colors.black,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.white54),
    border: InputBorder.none,
  ),
);