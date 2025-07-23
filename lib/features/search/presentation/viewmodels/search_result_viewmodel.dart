/*
 * @Author: Bon Ryan
 * @Created: 2025-07-23
 * @Page: search_result_viewmodel
 * @Description: This file defines the SearchResultViewModel used in the search feature.
 * It manages the state of search results, including current weather and forecasts for a given city.
 * It interacts with the SearchRepository to fetch weather data based on user input.
 * It is part of the search presentation layer and is used to display search results in the UI
 */ 

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/weather_config.dart';
import '../../domain/usecases/search_weather_usecase.dart';
import '../../../weather/domain/entities/weather.dart';
import '../../../weather/domain/entities/forecast.dart';
import '../../data/search_repository_imp.dart';


// Provide a ViewModel for search results
final searchResultViewModelProvider = StateNotifierProvider.autoDispose
    .family<SearchResultViewModel, AsyncValue<Weather>, String>((ref, cityName) {
  final weatherRepository = ref.watch(weatherRepositoryProvider); // Provided elsewhere
  final searchRepository = SearchRepositoryImp(weatherRepository);
  final usecase = SearchWeatherUsecase(searchRepository);
  return SearchResultViewModel(usecase)..fetchWeather(cityName);
});

final searchForecastProvider = FutureProvider.autoDispose.family<List<Forecast>, String>((ref, cityName) async {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final searchRepository = SearchRepositoryImp(weatherRepository);
  final usecase = SearchWeatherUsecase(searchRepository);
  return usecase.getForecast(cityName);
});

class SearchResultViewModel extends StateNotifier<AsyncValue<Weather>> {
  final SearchWeatherUsecase _usecase;

  SearchResultViewModel(this._usecase) : super(const AsyncValue.loading());

  Future<void> fetchWeather(String cityName) async {
    try {
      state = const AsyncValue.loading();
      final weather = await _usecase(cityName);
      state = AsyncValue.data(weather);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
