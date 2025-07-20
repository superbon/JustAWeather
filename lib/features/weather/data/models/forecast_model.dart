/*
 * @Author: Bon Ryan
 * @Created: 2025-07-19
 * @Page: forcast_model
 * @Description: This file contains the ForecastModel class for handling weather forecast data.
 * This class includes methods for converting between JSON and ForecastModel instances.
 * It is used to represent the weather forecast for a specific date and time.
 */

class ForecastModel {
  final DateTime date;
  final double temperature;
  final String condition;
  final String icon;

  ForecastModel({
    required this.date,
    required this.temperature,
    required this.condition,
    required this.icon,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      date: DateTime.parse(json['dt_txt']),
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt_txt': date.toIso8601String(),
      'main': {'temp': temperature},
      'weather': [
        {'main': condition, 'icon': icon}
      ],
    };
  }
}