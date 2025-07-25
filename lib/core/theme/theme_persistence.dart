/*
 * @Author: Bon Ryan
 * @Created: 2025-07-25
 * @Page: theme_persistence
 * @Description: This file contains the ThemePersistence class for saving and loading the application's theme mode.
 * It uses SharedPreferences to persist the user's theme choice (light, dark, or system).
 * It is used to maintain the user's theme preference across app restarts.
 * It is part of the core theme layer and is used in the main.dart file to set
 * the theme for the entire app.
 * 
 * @usage:
 * await ThemePersistence.saveThemeMode(ThemeMode.light);
 * final themeMode = await ThemePersistence.loadThemeMode();
 */

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ThemePersistence {
  static const _key = 'theme_mode';

  static Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, mode.index);
  }

  static Future<ThemeMode> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_key) ?? ThemeMode.system.index;
    return ThemeMode.values[index];
  }
}