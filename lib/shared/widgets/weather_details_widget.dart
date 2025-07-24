/*
 * @Author: Bon Ryan
 * @Created: 2025-07-23
 * @Page: weather_details_widget
 * @Description: This file defines the WeatherDetailsWidget class for displaying weather details.
 * It is part of the search presentation layer and is used to show weather information for a specific city.
 * The WeatherDetailsWidget is used to encapsulate the logic for displaying weather details.
 * It is used to provide a user-friendly interface for viewing weather information.
 * It is used in the SearchResultScreen to display the weather data after a search.
 * It is used to enhance the user experience by providing detailed weather information. 
 */

import 'package:flutter/material.dart';
import '../../features/weather/domain/entities/weather.dart';
import 'FrostedGlassCard.dart'; // Importing the FrostedGlassCard widget for styling
import '../../core/utils/string_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/settings/providers/temp_unit_provider.dart';

class WeatherDetailsWidget extends ConsumerWidget {
  final Weather weather;
  const WeatherDetailsWidget({
    required this.weather,
    super.key,
  }); // This widget displays detailed weather information for a specific city.

  double toFahrenheit(double c) => c * 9 / 5 + 32;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempUnitAsync = ref.watch(tempUnitProvider);

    String getTempString(TempUnit unit) {
      if (unit == TempUnit.celsius) {
        return '${weather.temperature.round()}°C';
      } else {
        return '${toFahrenheit(weather.temperature).round()}°F';
      }
    }

    return tempUnitAsync.when(
      data: (unit) => FrostedGlassCard(
        width: 400,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTempString(unit),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      weather.cityName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      weather.condition,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      weather.description.capitalize(),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Text(
                      '${weather.day} - ${weather.fulldate}',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                child: Image.network(
                  'https://openweathermap.org/img/wn/${weather.icon}@4x.png',
                  width: 180,
                  height: 180,
                  color: Colors.orangeAccent,
                  errorBuilder: (context, _, __) =>
                      const Icon(Icons.cloud, size: 64),
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Error: $e'),
    );
  }
}
