/*
 * @Author: Bon Ryan
 * @Created: 2025-07-22
 * @Page: settings_screen
 * @Description: This file contains the SettingsScreen class for managing application settings.
 * It includes options for changing the theme, language, and other preferences.
 * The SettingsScreen is part of the presentation layer and provides a user interface for adjusting settings.
 * It uses Riverpod for state management and allows users to customize their experience.
 * It is used to encapsulate the logic for managing application settings.
 * It is used to provide a user-friendly interface for adjusting settings.
 * It is used to display and manage user preferences in the application.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/temp_unit_provider.dart';
import '../../../../core/theme/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempUnitAsync = ref.watch(tempUnitProvider);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: tempUnitAsync.when(
        data: (unit) => ListView(
          children: [
            ListTile(
              title: const Text('Location List'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/locations'), // GoRouter navigation
            ),
            ListTile(
            title: Text('Theme'),
            trailing: DropdownButton<ThemeMode>(
              value: ref.watch(themeModeProvider),
              items: const [
                DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
              ],
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(themeModeProvider.notifier).setTheme(mode);
                }
              },
            ),
          ),
            ListTile(
              title: const Text('Temperature Unit'),
              trailing: DropdownButton<TempUnit>(
                value: unit,
                items: [
                  DropdownMenuItem(
                    value: TempUnit.celsius,
                    child: Text('Celsius (°C)'),
                  ),
                  DropdownMenuItem(
                    value: TempUnit.fahrenheit,
                    child: Text('Fahrenheit (°F)'),
                  ),
                ],
                onChanged: (TempUnit? newValue) {
                  if (newValue != null) {
                    ref.read(tempUnitProvider.notifier).setUnit(newValue);
                  }
                },
              ),
            ),
            // Add more settings options here
          ],
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
