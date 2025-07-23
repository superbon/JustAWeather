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
import '../../../weather/domain/entities/weather.dart';


class WeatherDetailsWidget extends StatelessWidget {
  final Weather weather;
  const WeatherDetailsWidget({required this.weather, super.key}); // This widget displays detailed weather information for a specific city.

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(weather.cityName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('${weather.temperature}°C', style: TextStyle(fontSize: 32)),
            Text(weather.condition, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}