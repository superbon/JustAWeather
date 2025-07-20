/*
 * @Author: Bon Ryan
 * @Created: 2025-07-19
 * @Page: weather_model
 * @Description: This file contains the WeatherModel class for handling weather data.
 * This class includes methods for converting between JSON and WeatherModel instances.
 * It is used to represent the current weather conditions for a specific city.
 */



class WeatherModel {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;
  final DateTime lastUpdated;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.lastUpdated,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {

    return WeatherModel(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      lastUpdated: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'main': {'temp': temperature},
      'weather': [
        {'main': condition, 'icon': icon}
      ],
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}