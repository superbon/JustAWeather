/*
 * @Author: Bon Ryan
 * @Created: 2025-07-20
 * @Page: weather_repository_imp
 * @Description: This file contains the WeatherRepositoryImp class for handling weather data operations.
 * It implements the WeatherRepository interface and provides methods for fetching and caching weather data.
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
        icon: model.icon,
        lastUpdated: model.lastUpdated,
      );
    } catch (_) {
      final cached = localDataSource.getCachedCurrentWeather(cityName);
      if (cached != null) {
        return Weather(
          cityName: cached.cityName,
          temperature: cached.temperature,
          condition: cached.condition,
          icon: cached.icon,
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
                icon: m.icon,
              ))
          .toList();
    }
  }
}
