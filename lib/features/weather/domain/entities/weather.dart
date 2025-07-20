/*
 * @Author: Bon Ryan
 * @Created: 2025-07-20
 * @Page: weather
 * @Description: This file defines the Weather entity used in the weather domain.
 * It represents the current weather conditions for a specific city.
 * It includes properties for city name, temperature, condition, icon, and last updated time.
 * It is used to encapsulate weather data retrieved from the weather API.
 * It is part of the weather domain layer.
 * It is used in the WeatherRepositoryImp class to return current weather data.
 */

class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;
  final DateTime lastUpdated;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.lastUpdated,
  });

  @override
  String toString() {
    return 'Weather(cityName: $cityName, temperature: $temperature, condition: $condition, icon: $icon, lastUpdated: $lastUpdated)';
  }
}