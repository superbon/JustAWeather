/*
 * @Author: Bon Ryan
 * @Created: 2025-07-19
 * @Page: weather_home_screen
 * @Description: This file contains the Weather Home Screen widget for displaying weather information.
 * It includes a search bar for city input, displays current weather conditions,
 * and a list of daily forecasts. It uses Riverpod for state management and LocationService
 * to fetch the current city based on the user's location.
 * It is part of the weather presentation layer.
 * It is used to encapsulate the logic for fetching and displaying weather data.
 * It is used to provide a user interface for viewing weather conditions and forecasts.
 * It is used to display weather information in a structured format.
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/viewmodels/weather_viewmodel.dart';
import '../../../../core/services/location_service.dart';
import 'package:go_router/go_router.dart';
//import '../widgets/forecast_list_widget.dart';
import '../widgets/weather_background_widget.dart';
import '../../../../shared/widgets/weather_details_widget.dart';
import '../../../../shared/widgets/forecast_list_widget.dart';
import '../../../weather/domain/exceptions/location_not_found_exception.dart';
import '../../../location/presentation/viewmodel/location_list_viewmodel.dart';

class WeatherHomeScreen extends ConsumerStatefulWidget {
  final String cityName;
  const WeatherHomeScreen({super.key, required this.cityName});

  @override
  ConsumerState<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends ConsumerState<WeatherHomeScreen> {
  String? _cityName;

  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) _searchController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    final viewModel = ref.read(
      weatherViewModelProvider(_cityName ?? widget.cityName).notifier,
    );
    try {
      final city = await LocationService.getCurrentCity();
      setState(() => _cityName = city);
      viewModel.fetchWeather(city);
    } catch (e) {
      debugPrint('Location error: $e');
      setState(() => _cityName = 'Manila');
      viewModel.fetchWeather('Manila');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provider access and state management at the screen level
    final weatherAsync = ref.watch(
      weatherViewModelProvider(_cityName ?? widget.cityName),
    );
    final forecastAsync = ref.watch(
      forecastProvider(_cityName ?? widget.cityName),
    );

    final locationsAsync = ref.watch(locationListViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          onPressed: _toggleSearch,
        ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Search city...',
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
                onSubmitted: (query) {
                  if (query.trim().isEmpty) return;
                  context.push('/search/${query.trim()}');
                  _searchController.clear();
                  _toggleSearch();
                },
              )
            : const Text(
                'Just a Weather',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push('/settings');
            },
          ),
        ],
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
                      textAlign: TextAlign.center,
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
                    const SizedBox(height: 16),
                    const Text(
                      "Saved Locations",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    locationsAsync.when(
                      data: (locations) {
                        if (locations.isEmpty) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Wrap(
                            spacing: 8,
                            children: locations
                                .map(
                                  (loc) => ActionChip(
                                    label: Text(loc.name),
                                    onPressed: () {
                                      // Push to weather/search result screen for that location
                                      context.pushNamed(
                                        'searchResult',
                                        pathParameters: {
                                          'city': Uri.encodeComponent(loc.name),
                                        },
                                      );
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (e, _) => const SizedBox.shrink(),
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
