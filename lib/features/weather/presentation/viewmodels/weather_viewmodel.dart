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
import '../../../../config/weather_config.dart';
import 'package:intl/intl.dart';
import '../../domain/usecases/get_weather_usecase.dart';


final weatherViewModelProvider = StateNotifierProvider.family<WeatherViewModel, AsyncValue<Weather>, String>((ref, cityName) {
  final repository = ref.watch(weatherRepositoryProvider);   // from data 
  final getWeather = GetWeatherUseCase(repository); // use case
  final vm = WeatherViewModel(getWeather: getWeather);
  vm.fetchWeather(cityName); // Automatically fetches on instantiation
  return vm;
});

final forecastProvider = FutureProvider.autoDispose.family<List<Forecast>, String>((ref, cityName) async {
  final repository = ref.watch(weatherRepositoryProvider); 
  final getWeather = GetWeatherUseCase(repository);
  return await getWeather.getFiveDayForecast(cityName);
});

class WeatherViewModel extends StateNotifier<AsyncValue<Weather>> {
  final GetWeatherUseCase _getWeather;

  WeatherViewModel({required GetWeatherUseCase getWeather}) 
      : _getWeather = getWeather,
        super(const AsyncValue.loading());

  Future<void> fetchWeather(String cityName) async {
    try {
      final weather = await _getWeather(cityName); // call use case
      state = AsyncValue.data(weather);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<List<Forecast>> getFiveDayForecast(String cityName) {
    return _getWeather.getFiveDayForecast(cityName); // use case
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
