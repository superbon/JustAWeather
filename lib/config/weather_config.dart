/*
 * @Author: Bon Ryan
 * @Created: 2025-07-20
 * @Page: weather_config
 * @Description: This file contains the configuration for the weather feature.
 * It includes the base URL for the weather API and the API key.
 * It is used to centralize the configuration settings for the weather feature.
 * It allows for easy modification of the API settings without changing the codebase.
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/weather/data/datasources/weather_remote_datasource.dart';
import '../features/weather/data/datasources/weather_local_datasource.dart';
import '../features/weather/data/repository/weather_repository_imp.dart';
import '../features/weather/domain/repositories/weather_repository.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class WeatherConfig {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = '503e82e0ab189dbfa69bf3cf523c1438'; // Replace with your actual API key 
  static const String units = 'metric'; // Use 'metric' for Celsius, 'imperial' for Fahrenheit
}

// Providers should be declared at the top-level, outside of any class.
final dioProvider = Provider<Dio>((ref) => Dio());

final apiKeyProvider = Provider<String>((ref) => WeatherConfig.apiKey);

final weatherBoxProvider = Provider<Box>((ref) => Hive.box('weatherBox'));
final forecastBoxProvider = Provider<Box>((ref) => Hive.box('forecastBox'));

final weatherRemoteDataSourceProvider = Provider<WeatherRemoteDataSource>((ref) {
  return WeatherRemoteDataSource(
    dio: ref.watch(dioProvider),
    apiKey: ref.watch(apiKeyProvider),
  );
});

final weatherLocalDataSourceProvider = Provider<WeatherLocalDataSource>((ref) {
  return WeatherLocalDataSource(
    weatherBox: ref.watch(weatherBoxProvider),
    forecastBox: ref.watch(forecastBoxProvider),
  );
});

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepositoryImp(
    remoteDataSource: ref.watch(weatherRemoteDataSourceProvider),
    localDataSource: ref.watch(weatherLocalDataSourceProvider),
  );
});

