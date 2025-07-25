import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:justaweather/config/router.dart';
import 'config/router.dart'; 

import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Step 1: Initialize Hive
  await Hive.initFlutter();

  // Step 2: Open boxes
  await Hive.openBox('weatherBox');
  await Hive.openBox('forecastBox');

  // Step 3: Wrap in ProviderScope and run
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  // Constructor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
