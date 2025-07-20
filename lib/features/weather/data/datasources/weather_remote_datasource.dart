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
import 'package:justaweather/config/weather_config.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../../../../config/weather_config.dart';

class WeatherRemoteDataSource {
  // This class will handle remote data fetching operations for weather data.
  // It can use Dio, http, or any other HTTP client library.
  
 final Dio dio;
 final String apiKey;

  WeatherRemoteDataSource({required this.dio, required this.apiKey});

  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response = await dio.get(
      '${WeatherConfig.baseUrl}/weather',
      queryParameters: {
        'q': cityName,
        'appid': apiKey,
        'units': WeatherConfig.units, // Use the units defined in WeatherConfig
      },
    );
    return WeatherModel.fromJson(response.data);
  }

  Future<List<ForecastModel>> getFiveDayForecast(String cityName) async {
    final response = await dio.get(
      '${WeatherConfig.baseUrl}/forecast',
      queryParameters: {
        'q': cityName,
        'appid': apiKey,
        'units': WeatherConfig.units,
      },
    );
    final List<dynamic> list = response.data['list'];
    return list.map((e) => ForecastModel.fromJson(e)).toList();
  }
}