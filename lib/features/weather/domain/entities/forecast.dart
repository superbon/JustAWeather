/*
 * @Author: Bon Ryan
 * @Created: 2025-07-20
 * @Page: forecast
 * @Description: This file defines the Forecast entity used in the weather domain.
 * It represents the weather forecast for a specific date.
 * It includes properties for date, temperature, condition, and icon.
 * It is used to encapsulate forecast data retrieved from the weather API.
 * It is part of the weather domain layer.
 * It is used in the WeatherRepositoryImp class to return forecast data.
 */

import 'package:intl/intl.dart';

class Forecast {
  final DateTime date;
  final double temperature;
  final String condition;
  final String description;
  final String icon;

  Forecast({
    required this.date,
    required this.temperature,
    required this.condition,
    required this.description,
    required this.icon,
  });

  String get day => DateFormat('E').format(date); // e.g., 'Mon'

  @override
  String toString() {
    return 'Forecast(date: $date, temperature: $temperature, condition: $condition, icon: $icon, description: $description)';
  }
}