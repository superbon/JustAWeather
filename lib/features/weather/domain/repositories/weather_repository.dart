/*
 * @Author: Bon Ryan
 * @Created: 2025-07-20
 * @Page: weather_repository
 * @Description: This file defines the WeatherRepository interface for the weather domain.
 * It declares methods for fetching current weather and a five-day forecast for a given city.
 * It is part of the weather domain layer and is implemented by the WeatherRepositoryImp class.
 * It is used to abstract the data source layer from the domain layer.
 * It allows for easy testing and mocking of weather data operations.
 */

import '../entities/weather.dart';
import '../entities/forecast.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentWeather(String cityName);
  Future<List<Forecast>> getFiveDayForecast(String cityName);
}