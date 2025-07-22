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

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Change Theme'),
            onTap: () {
              // Logic to change theme
            },
          ),
          ListTile(
            title: const Text('Change Language'),
            onTap: () {
              // Logic to change language
            },
          ),
          // Add more settings options here
        ],
      ),
    );
  }
}