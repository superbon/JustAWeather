import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:justaweather/features/weather/presentation/views/weather_home_screen.dart';
import 'package:justaweather/features/weather/presentation/views/weather_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:justaweather/core/services/location_service.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String>(
        future: (() async {
  try {
    return await LocationService.getCurrentCity();
  } catch (e) {
    debugPrint('Location error: $e');
    return 'Manila'; // fallback
  }
})(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return const Scaffold(body: Center(child: Text('Failed to get location')));
          } else {
            return WeatherScreen(cityName: snapshot.data!);
          }
        },
      ),
    );
  }
}
