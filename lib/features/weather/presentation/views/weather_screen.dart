/*
 * @Author: Bon Ryan
 * @Created: 2025-07-20
 * @Page: weather_screen
 * @Description: This file contains the WeatherScreen widget for displaying current weather and forecast information.
 * It uses Riverpod for state management and displays weather data for a specified city.
 * It includes an AppBar with the city name, current weather details, and a list of forecast items.
 * It handles loading and error states for both current weather and forecast data.
 * It is part of the weather presentation layer.
 * It is used in the WeatherHomeScreen widget to display weather information.
 * It is used to encapsulate the logic for fetching and displaying weather data.
 * It is used to provide a user interface for viewing weather conditions and forecasts.
 * It is used to display weather information in a structured format.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/viewmodels/weather_viewmodel.dart';
import '../../../../core/services/location_service.dart';


class WeatherScreen extends ConsumerWidget {
  final String cityName;

  const WeatherScreen({super.key, required this.cityName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final viewModel = ref.read(weatherViewModelProvider.notifier);
  final weather = ref.watch(weatherViewModelProvider);
  final forecast = ref.watch(forecastProvider(cityName));

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    try {
      final city = await LocationService.getCurrentCity();
      viewModel.fetchWeather(city);
    } catch (e) {
      // handle error: permission denied, service off, etc.
      debugPrint('Location error: $e');
      viewModel.fetchWeather("Manila"); // fallback
    }
  });

    

    return Scaffold(
      appBar: AppBar(title: Text(cityName)),
      body: weather.when(
        data: (w) => Column(
          children: [
            Text('${w.cityName} - ${w.temperature}°C'),
            Text(w.condition),
            forecast.when(
              data: (list) => Expanded(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final f = list[index];
                    return ListTile(
                      title: Text('${f.date.hour}:00 - ${f.temperature}°C'),
                      subtitle: Text(f.condition),
                      leading: Image.asset('assets/images/${f.icon}.png', width: 40),
                    );
                  },
                ),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Forecast error: $e'),
            )
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}