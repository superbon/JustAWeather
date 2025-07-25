
/*
 * @Author: Bon Ryan
 * @Created: 2025-07-25
 * @Page: theme_provider
 * @Description: This file contains the ThemeProvider for managing the application's theme mode.
 * It allows the user to switch between light, dark, and system themes.
 * It is used to provide the current theme mode to the application.
 * It is part of the core theme layer and is used in the main.dart file to set
 * the theme for the entire app.
 * 
 * @usage:
 * final themeMode = ref.watch(themeModeProvider);
 * ref.read(themeModeProvider.notifier).setTheme(ThemeMode.light);
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_persistence.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _load();
  }

  Future<void> _load() async {
    state = await ThemePersistence.loadThemeMode();
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    await ThemePersistence.saveThemeMode(mode);
  }
}