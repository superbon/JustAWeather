import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:justaweather/features/weather/presentation/views/weather_home_screen.dart';
import 'package:justaweather/features/weather/presentation/views/weather_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:justaweather/core/services/location_service.dart';
import 'package:go_router/go_router.dart';
import 'package:justaweather/config/router.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
