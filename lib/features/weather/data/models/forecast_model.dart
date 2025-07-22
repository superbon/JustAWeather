/*
 * @Author: Bon Ryan
 * @Created: 2025-07-19
 * @Page: forcast_model
 * @Description: This file contains the ForecastModel class for handling weather forecast data.
 * This class includes methods for converting between JSON and ForecastModel instances.
 * It is used to represent the weather forecast for a specific date and time.
 */
import 'package:flutter/foundation.dart';

class ForecastModel {
  final DateTime date;
  final double temperature;
  final String condition;
  final String description;
  final String icon;

  ForecastModel({
    required this.date,
    required this.temperature,
    required this.condition,
    required this.description,
    required this.icon,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {

    final weatherList = json['weather'] as List<dynamic>? ?? [];
    final weather = weatherList.isNotEmpty
        ? (weatherList[0] as Map).cast<String, dynamic>()
        : <String, dynamic>{};

    if (kDebugMode) {
      print('Weather JSON: $weatherList');
    }
    return ForecastModel(
      date: DateTime.parse(json['dt_txt']),
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'] ?? '',
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt_txt': date.toIso8601String(),
      'main': {'temp': temperature},
      'weather': [
        {'main': condition, 'description': description, 'icon': icon}
      ],
    };
  }
}