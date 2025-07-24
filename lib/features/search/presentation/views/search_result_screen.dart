/*
 * @Author: Bon Ryan
 * @Created: 2025-07-23
 * @Page: search_result_screen
 * @Description: This file contains the SearchResultScreen class for displaying search results.
 * It is used to show weather details for a specific city after a search.
 * The SearchResultScreen is part of the presentation layer and provides a user interface for displaying weather information.
 * It uses Riverpod for state management and allows users to view weather details for a searched city.
 * It is used to encapsulate the logic for displaying search results.
 * It is used to provide a user-friendly interface for viewing weather information.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/viewmodels/search_result_viewmodel.dart';
import '../../../../shared/widgets/weather_details_widget.dart';
import '../../../../shared/widgets/forecast_list_widget.dart';
import '../../../weather/domain/exceptions/location_not_found_exception.dart';
import '../../../weather/presentation/widgets/weather_background_widget.dart';

class SearchResultScreen extends ConsumerWidget {
  final String cityName;
  const SearchResultScreen({required this.cityName, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(searchResultViewModelProvider(cityName));
    final forecastAsync = ref.watch(searchForecastProvider(cityName));
    final searchController = TextEditingController(text: cityName);

    print("weatherAsync: $weatherAsync");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: TextField(
          controller: searchController,
          autofocus: false,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            hintText: 'Search city...',
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
          ),
          onSubmitted: (query) {
            if (query.trim().isEmpty) return;
            context.go('/search/${Uri.encodeComponent(query.trim())}');
            FocusScope.of(context).unfocus();
          },
          textInputAction: TextInputAction.search,
        ),
        centerTitle: true,
      ),
      body: weatherAsync.when(
        data: (weather) => Stack(
          children: [
            WeatherBackgroundWidget(condition: weather.condition),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ), // You can adjust values
                      child: Align(
                        alignment: Alignment
                            .centerLeft, // This will left-align the widget
                        child: WeatherDetailsWidget(weather: weather),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "5-Day Forecast",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    forecastAsync.when(
                      data: (forecastList) =>
                          ForecastListWidget(forecasts: forecastList),
                      loading: () => const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: CircularProgressIndicator(),
                      ),
                      error: (e, _) => Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          'Forecast error: $e',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              (e is LocationNotFoundException)
                  ? 'Location not found.\nPlease check the spelling or try another location.'
                  : 'Weather error: $e',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}