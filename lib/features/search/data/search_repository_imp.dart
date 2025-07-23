/*
 * @Author: Bon Ryan
 * @Created: 2025-07-23
 * @Page: search_repository_imp
 * @Description: This file implements the SearchRepository interface for searching weather data.
 */

import '../domain/repositories/search_repository.dart';
import '../../weather/domain/entities/weather.dart';
import '../../weather/domain/entities/forecast.dart';
import '../../weather/domain/repositories/weather_repository.dart';

class SearchRepositoryImp implements SearchRepository {
  final WeatherRepository weatherRepository; // Injected WeatherRepository to handle weather data operations

  SearchRepositoryImp(this.weatherRepository);// Constructor to initialize the repository

  @override
  Future<Weather> searchWeather(String cityName) async { // Uses WeatherRepository to fetch current weather data for the given city
    return await weatherRepository.getCurrentWeather(cityName); // Uses WeatherRepository to fetch current weather data for the given city
  }

  @override
  Future<List<Forecast>> searchForecast(String cityName) async { 
    return await weatherRepository.getFiveDayForecast(cityName); // Uses WeatherRepository to fetch a five-day forecast for the given city
  }
}