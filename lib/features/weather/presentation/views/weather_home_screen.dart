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
import 'package:justaweather/features/weather/domain/entities/forecast.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

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
    final viewModel = ref.read(weatherViewModelProvider.notifier);
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
    final weather = ref.watch(weatherViewModelProvider);
    final forecast = ref.watch(forecastProvider(_cityName ?? widget.cityName));
    final viewModel = ref.read(weatherViewModelProvider.notifier);

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
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search city...',
                  hintStyle: TextStyle(color: Colors.white60),
                  border: InputBorder.none,
                ),
                onSubmitted: (query) {
                  // TODO: Trigger search logic (e.g. viewModel.search(query))
                },
              )
            : const Text(
                'Weather App',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings screen
              context.push('/settings');
            },
          ),
        ],
      ),
      body: weather.when(
        data: (w) => Column(
          children: [
            Text('${w.cityName} - ${w.temperature}°C'),
            Text(w.condition),
            Text(w.description),
            forecast.when(
              data: (list) {
                final dailyForecasts = viewModel.getDailyForecasts(list);
                return Expanded(child: ListViewForecast(dailyForecasts));
              },
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Forecast error: $e'),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error this: $e')),
      ),
    );
  }

  ListView ListViewForecast(List<Forecast> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final f = list[index];
        final dayString = DateFormat('E').format(f.date);
        final dateString = DateFormat('MMM d').format(f.date);
        final timeString = DateFormat('h:mm a').format(f.date);

        return ListTile(
          leading: Image.network(
            'https://openweathermap.org/img/wn/${f.icon}@2x.png',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) =>
                progress == null ? child : const CircularProgressIndicator(),
            errorBuilder: (context, error, stackTrace) {
              print('Failed to load icon: ${f.icon}');
              return const Icon(Icons.error, size: 40, color: Colors.red);
            },
          ),
          title: Text('${f.temperature}°C  •  ${f.condition} - ${f.description}'),
          subtitle: Text('$dayString, $dateString'),
        );
      },
    );
  }
}
