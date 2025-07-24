/*
 * @Author: Bon Ryan
 * @Created: 2025-07-24
 * @Page: weather_model
 * @Description: This file contains the WeatherModel class for handling current weather data.
 * It includes methods for converting between JSON and WeatherModel instances.
 * It is used to represent the current weather for a specific city.
 * It is part of the weather data layer and is used to encapsulate weather data retrieved from the weather API.
 * It is used in the WeatherRepositoryImp class to return current weather data.
 * It is also used in the WeatherViewModel to provide weather data to the UI.
 * It is used to abstract the data source layer from the domain layer.
 * It allows for easy testing and mocking of weather data operations.
 * 
 * @File: lib/features/weather/data/models/weather_model.dart
 */


class WeatherModel {
  final String cityName;
  final double temperature;
  final String condition;
  final String description;
  final String icon;
  final DateTime date;
  final DateTime lastUpdated;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.description,
    required this.icon,
    required this.date,
    required this.lastUpdated,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
print("Parsing weather: city=${json['name']}, cond=${json['weather'][0]['main']}, temp=${json['main']['temp']}");
  
    return WeatherModel(
      cityName: json['name'],
      temperature: (json['main']['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
      lastUpdated: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'dt': date.millisecondsSinceEpoch ~/ 1000,
      'main': {'temp': temperature},
      'weather': [
        {'main': condition, 'description': description, 'icon': icon}
      ],
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}