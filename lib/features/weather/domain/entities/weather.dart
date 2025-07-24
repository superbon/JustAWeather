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

import 'package:intl/intl.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final String description;
  final String icon;
  final DateTime date;
  final DateTime lastUpdated;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.description,
    required this.icon,
    required this.date,
    required this.lastUpdated,
  });

  String get day => DateFormat('E').format(date); // e.g., 'Mon'
  String get time => DateFormat('hh:mm a').format(date); 
  String get fulldate => DateFormat('MMM d, y').format(date);  
  String get fullday => DateFormat('EEEE').format(date); 

  @override
  String toString() {
    return 'Weather(cityName: $cityName, temperature: $temperature, condition: $condition, icon: $icon, lastUpdated: $lastUpdated, description: $description, date: $date)';
  }
}