/*
 * @Author: Bon Ryan
 * @Created: 2025-07-23
 * @Page: forecast_list_widget
 * @Description: This file defines the ForecastListWidget for displaying a list of weather forecasts.
 * It is part of the search presentation layer and is used to show a horizontal list of forecasts for a specific city.
 * The ForecastListWidget is used to encapsulate the logic for displaying weather forecasts.
 * It provides a user-friendly interface for viewing upcoming weather conditions.
 * It is used to enhance the user experience by providing a quick overview of weather forecasts.
 * It is used in the SearchResultScreen to display the forecast data after a search.
 */

import 'package:flutter/material.dart';
import '../../../weather/domain/entities/forecast.dart';

class ForecastListWidget extends StatelessWidget {
  final List<Forecast> forecasts;
  const ForecastListWidget({required this.forecasts, super.key}); // This widget displays a horizontal list of weather forecasts for a specific city.

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecasts.length,
        itemBuilder: (context, idx) {
          final forecast = forecasts[idx];
          return Card(
            child: Container(
              width: 100,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(forecast.day, style: TextStyle(fontWeight: FontWeight.bold)),
                  Icon(Icons.wb_sunny), // Use weather icon logic as needed
                  Text('${forecast.temperature}°C'),
                  Text(forecast.condition, style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
