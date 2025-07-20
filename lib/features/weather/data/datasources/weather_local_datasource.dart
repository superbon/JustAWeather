/*
 * @Author: Bon Ryan
 * @Created: 2025-07-19
 * @Page: weather_local_datasource
 * @Description: This file contains the WeatherLocalDataSource class for handling local weather data storage.
 * It includes methods for saving and retrieving weather data from local storage.
 */


import 'package:hive/hive.dart';

import '../models/weather_model.dart';
import '../models/forecast_model.dart';


class WeatherLocalDataSource {
  // This class will handle local storage operations for weather data.
  // It can use shared preferences, SQLite, or any other local storage solution.
  WeatherLocalDataSource({required this.weatherBox, required this.forecastBox});

  final Box weatherBox;
  final Box forecastBox;

  Future<void> cacheCurrentWeather(String city, WeatherModel model) async {
    // Save the current weather data for a specific city
    await weatherBox.put(city, model.toJson());
  }

  WeatherModel? getCachedCurrentWeather(String city) {
    final data = weatherBox.get(city);
    if (data != null) {
      return WeatherModel.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  Future<void> cacheForecast(String city, List<ForecastModel> models) async {
    // Save the weather forecast data for a specific city
    final dataList = models.map((e) => e.toJson()).toList();
    await forecastBox.put(city, dataList);
  }

  List<ForecastModel> getCachedForecast(String city) {
    final data = forecastBox.get(city);
    if (data != null && data is List) {
      return data
          .map((e) => ForecastModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }
}