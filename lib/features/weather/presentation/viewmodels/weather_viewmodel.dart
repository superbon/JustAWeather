/*
 * @Author: Bon Ryan
 * @Created: 2025-07-20
 * @Page: weather_viewmodel
 * @Description: This file contains the WeatherViewModel class for managing weather data.
 * It uses Riverpod for state management and provides methods to fetch current weather and forecast data.
 * It includes providers for current weather and forecast data, handling loading and error states.
 * It is part of the weather presentation layer.
 * It is used in the WeatherScreen widget to display weather information for a specified city.
 * It is used to encapsulate the logic for fetching and managing weather data.
 * It is used in the WeatherRepositoryImp class to return current weather and forecast data.
 */


import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/weather.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../../../config/weather_config.dart';
import 'package:intl/intl.dart';


final weatherViewModelProvider = StateNotifierProvider<WeatherViewModel, AsyncValue<Weather>>((ref) {
  final repository = ref.watch(weatherRepositoryProvider);
  return WeatherViewModel(repository: repository);
});

final forecastProvider = FutureProvider.autoDispose.family<List<Forecast>, String>((ref, cityName) async {
  final repository = ref.watch(weatherRepositoryProvider);
  return await repository.getFiveDayForecast(cityName);
});

class WeatherViewModel extends StateNotifier<AsyncValue<Weather>> {
  final WeatherRepository _repository;

  WeatherViewModel({required WeatherRepository repository}) 
      : _repository = repository,
        super(const AsyncValue.loading());

  Future<void> fetchWeather(String cityName) async {
    try {
      final weather = await _repository.getCurrentWeather(cityName);
      state = AsyncValue.data(weather);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  List<Forecast> getDailyForecasts(List<Forecast> all) {
  final Map<String, Forecast> daily = {};
  for (final f in all) {
    final key = DateFormat('yyyy-MM-dd').format(f.date);
    if (!daily.containsKey(key) ||
        (daily[key] != null &&
         (f.date.hour - 12).abs() < (daily[key]!.date.hour - 12).abs())) {
      daily[key] = f;
    }
  }
  return daily.values.toList();
}
}
