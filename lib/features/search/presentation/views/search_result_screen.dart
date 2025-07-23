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
import '../widgets/weather_details_widget.dart';
import '../widgets/forecast_list_widget.dart';
import '../../../weather/domain/exceptions/location_not_found_exception.dart';

class SearchResultScreen extends ConsumerStatefulWidget {
  final String cityName;
  const SearchResultScreen({required this.cityName, super.key});

  @override
  ConsumerState<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends ConsumerState<SearchResultScreen> {
  late TextEditingController _searchController;
  late String _currentCity;

  @override
  void initState() {
    super.initState();
    _currentCity = widget.cityName;
    _searchController = TextEditingController(text: _currentCity);
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) return;
    context.go('/search/${Uri.encodeComponent(query.trim())}');
    setState(() {
      _currentCity = query.trim();
    });
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherAsync = ref.watch(searchResultViewModelProvider(_currentCity));
    final forecastAsync = ref.watch(searchForecastProvider(_currentCity));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: false,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            hintText: 'Search city...',
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
          ),
          onSubmitted: _onSearch,
          textInputAction: TextInputAction.search,
        ),
        centerTitle: true,
      ), 
      body: SingleChildScrollView(
        child: Column(
          children: [
            weatherAsync.when(
              data: (weather) => WeatherDetailsWidget(weather: weather),
              loading: () => const Padding(
                padding: EdgeInsets.all(24.0),
                child: CircularProgressIndicator(),
              ),
              error: (e, _) => Padding(
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
            const SizedBox(height: 16),
            Text(
              "5-Day Forecast",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
    );
  }
}
