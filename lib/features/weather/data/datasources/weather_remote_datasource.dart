/*
 * @Author: Bon Ryan
 * @Created: 2025-07-19
 * @Page: weather_remote_datasource
 * @Description: This file contains the WeatherRemoteDataSource class for handling remote weather data fetching.
 * It includes methods for fetching current weather and forecast data from a remote API.
 * This class is used to interact with the weather API and retrieve data for the application.
 * It uses the Dio package for making HTTP requests and handles JSON parsing.
 * 
 */

import 'package:dio/dio.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';

class WeatherRemoteDataSource {
  // This class will handle remote data fetching operations for weather data.
  // It can use Dio, http, or any other HTTP client library.
  
  final Dio dio;
  final String apiKey;

  WeatherRemoteDataSource({required this.dio});

  Future<WeatherModel> fetchCurrentWeather(String city) async {
    final response = await dio.get('https://api.openweathermap.org/data/2.5/weather', queryParameters: {
      'q': city,
      'appid': apiKey,
      'units': 'metric',
    });

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load current weather');
    }
  }

  Future<List<ForecastModel>> fetchForecast(String city) async {
    final response = await dio.get('https://api.openweathermap.org/data/2.5/forecast', queryParameters: {
      'q': city,
      'appid': apiKey,
      'units': 'metric',
    });

    if (response.statusCode == 200) {
      final List<dynamic> forecastList = response.data['list'];
      return forecastList.map((e) => ForecastModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load forecast');
    }
  }
}