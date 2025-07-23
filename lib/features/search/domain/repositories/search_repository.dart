/*
 * @Author: Bon Ryan
 * @Created: 2025-07-23
 * @Page: search_repository
 * @Description: This file defines the SearchRepository interface for searching weather data.
 * It declares methods for searching current weather and a five-day forecast for a given city.
 * It is part of the search domain layer and is implemented by the SearchRepositoryImp class.
 * It is used to abstract the data source layer from the search layer.
 * It allows for easy testing and mocking of search operations.
 */

import '../../../weather/domain/entities/weather.dart';
import '../../../weather/domain/entities/forecast.dart';

abstract class SearchRepository {
  Future<Weather> searchWeather(String cityName);
  Future<List<Forecast>> searchForecast(String cityName);
}