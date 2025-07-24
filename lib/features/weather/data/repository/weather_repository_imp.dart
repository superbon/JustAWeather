/*
 * @Author: Bon Ryan
 * @Created: 2025-07-24
 * @Page: weather_repository_imp
 * @Description: This file implements the WeatherRepository interface.
 * It provides methods to fetch current weather and a five-day forecast.
 * It uses local and remote data sources to retrieve and cache weather data.
 * It handles exceptions and returns cached data when remote data is unavailable.
 * It is part of the weather data layer and is used by the GetWeatherUseCase.
 * It encapsulates the logic for interacting with weather data sources.
 * It is used in the WeatherViewModel to provide weather data to the presentation layer.
 * It is used to abstract the data source layer from the domain layer.
 * It allows for easy testing and mocking of weather data operations.
 * 
 * 
 * @File: lib/features/weather/data/repository/weather_repository_imp.dart
 * 
 * 
 */


import '../../domain/entities/weather.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_datasource.dart';
import '../datasources/weather_local_datasource.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';

class WeatherRepositoryImp implements WeatherRepository {
  final WeatherLocalDataSource localDataSource;
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImp({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Weather> getCurrentWeather(String cityName) async {
    try {
      final WeatherModel model = await remoteDataSource.getCurrentWeather(cityName);
      await localDataSource.cacheCurrentWeather(cityName, model);
      return Weather(
        cityName: model.cityName,
        temperature: model.temperature,
        condition: model.condition,
        description: model.description,
        icon: model.icon,
        date: model.date,
        lastUpdated: model.lastUpdated,
      );
    } catch (_) {
      final cached = localDataSource.getCachedCurrentWeather(cityName);
      if (cached != null) {
        return Weather(
          cityName: cached.cityName,
          temperature: cached.temperature,
          condition: cached.condition,
          description: cached.description,
          icon: cached.icon,
          date: cached.date,
          lastUpdated: cached.lastUpdated,
        );
      }
      rethrow;
    }
  }

  @override
  Future<List<Forecast>> getFiveDayForecast(String cityName) async {
    try {
      final List<ForecastModel> models = await remoteDataSource.getFiveDayForecast(cityName);
      await localDataSource.cacheForecast(cityName, models);
      return models
          .map((m) => Forecast(
                date: m.date,
                temperature: m.temperature,
                condition: m.condition,
                description: m.description,
                icon: m.icon,
              ))
          .toList();
    } catch (_) {
      final cached = localDataSource.getCachedForecast(cityName);
      return cached
          .map((m) => Forecast(
                date: m.date,
                temperature: m.temperature,
                condition: m.condition,
                description: m.description,
                icon: m.icon,
              ))
          .toList();
    }
  }
}
