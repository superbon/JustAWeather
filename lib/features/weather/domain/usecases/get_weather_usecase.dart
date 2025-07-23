/*
 * @Author: Bon Ryan
 * @Created: 2025-07-23
 * @Page: get_weather
 * @Description: This file contains the GetWeather use case for fetching weather data.
 * It defines methods for retrieving current weather and a five-day forecast for a given city.
 * It is part of the weather domain layer and interacts with the WeatherRepository.
 * This use case is used to encapsulate the business logic for fetching weather data.
 */

import 'package:justaweather/features/weather/domain/entities/weather.dart';
import 'package:justaweather/features/weather/domain/entities/forecast.dart';
import 'package:justaweather/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<Weather> call(String cityName) async {
    return await repository.getCurrentWeather(cityName);
  }

  Future<List<Forecast>> getFiveDayForecast(String cityName) async {
    return await repository.getFiveDayForecast(cityName);
  }
}