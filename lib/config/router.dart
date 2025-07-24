/*
 * @Author: Bon Ryan
 * @Created: 2025-07-22
 * @Page: router
 * @Description: This file defines the router configuration for the JustAWeather application.
 * It sets up the routes for the main application, including the home screen and weather details.
 * It uses the GoRouter package to manage navigation and deep linking.
 * The router is used to navigate between different views in the application.
 * It is part of the core configuration layer and can be used to define additional routes as needed.
 * It is used to encapsulate the logic for routing and navigation in the application.
 * It is used to provide a structured way to manage application routes and navigation.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:justaweather/features/settings/presentation/views/settings_screen.dart';
import 'package:justaweather/features/weather/presentation/views/weather_home_screen.dart';
import 'package:justaweather/core/services/location_service.dart';
import 'package:justaweather/features/search/presentation/views/search_result_screen.dart';
import 'package:justaweather/features/location/presentation/views/location_list_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) {
        return FutureBuilder<String>(
          future: (() async {
            try {
              return await LocationService.getCurrentCity();
            } catch (e) {
              return 'Manila';
            }
          })(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return const Scaffold(
                body: Center(child: Text('Failed to get location')),
              );
            } else {
              return WeatherHomeScreen(cityName: snapshot.data!);
            }
          },
        );
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) =>
          SettingsScreen(), // Replace with your actual settings screen
    ),
    GoRoute(
      path: '/locations',
      builder: (context, state) => LocationListScreen(),
    ),
    GoRoute(
      path: '/search/:city',
      name: 'searchResult',
      builder: (context, state) {
        final city = Uri.decodeComponent(state.pathParameters['city']!);
        return SearchResultScreen(
          key: ValueKey(city), 
          cityName: city,
        );
      },
    ), // Add other routes here
  ],
);
