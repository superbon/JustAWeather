/*
 * @Author: Bon Ryan
 * @Created: 2025-07-19
 * @Page: weather_home_screen
 * @Description: This file contains the Weather Home Screen widget for displaying weather information.
 */


import 'package:flutter/material.dart';


class WeatherHomeScreen extends StatelessWidget {
  const WeatherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The '),
      ),
      body: Center(
        child: Text(
          'Welcome to the Weather Home Screen!'
        ),
      ),
    );
  }
}