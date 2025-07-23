/*
 * @Author: Bon Ryan
 * @Created: 2025-07-23
 * @Page: search_weather_usecase
 * @Description: This file defines the SearchWeatherUseCase class for searching weather data.
 * It implements the SearchWeatherUseCase interface and uses the SearchRepository to perform search operations.
 * It is part of the search domain layer and is used to encapsulate the logic for searching weather data.
 * It allows for easy testing and mocking of search operations.
 */

import '../repositories/search_repository.dart';
import '../../../weather/domain/entities/weather.dart';
import '../../../weather/domain/entities/forecast.dart';

class SearchWeatherUsecase {
  final SearchRepository repository;
  SearchWeatherUsecase(this.repository);

  Future<Weather> call(String cityName) {
    return repository.searchWeather(cityName);
  }

  Future<List<Forecast>> getForecast(String cityName) {
    return repository.searchForecast(cityName);
  }
}