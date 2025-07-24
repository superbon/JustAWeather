/*
 * @Author: Bon Ryan
 * @Created: 2025-07-24
 * @Page: weather_background_widget
 * @Description: This file contains the WeatherBackgroundWidget class for displaying weather background images.
 * It is used to provide a visually appealing background based on the current weather conditions.
 */

import 'package:flutter/material.dart';

class WeatherBackgroundWidget extends StatelessWidget {
  final String condition;
  const WeatherBackgroundWidget({super.key, required this.condition});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_getBackgroundImage()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  String _getBackgroundImage() {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'assets/images/backgrounds/clear.png';
      case 'sunny':
        return 'assets/images/backgrounds/clear.png';
      case 'clouds':
        return 'assets/images/backgrounds/clouds.png';
      case 'cloudy':
        return 'assets/images/backgrounds/clouds.png';
      case 'rain':
        return 'assets/images/backgrounds/rain.png';
      case 'rainy':
        return 'assets/images/backgrounds/rain.png';
      case 'drizzle':
        return 'assets/images/backgrounds/drizzle.png';
      case 'snow':
        return 'assets/images/backgrounds/snow.png';
      case 'snowy':
        return 'assets/images/backgrounds/snow.png';
      case 'fog':
        return 'assets/images/backgrounds/fog.png';
      case 'mist':
        return 'assets/images/backgrounds/mist.png';
      case 'haze':
        return 'assets/images/backgrounds/haze.png';
      case 'sand':
        return 'assets/images/backgrounds/sand.png';
      case 'dust':
        return 'assets/images/backgrounds/dust.png';
      case 'smoke':
        return 'assets/images/backgrounds/smoke.png';
      case 'ash':
        return 'assets/images/backgrounds/ash.png';
      case 'squall':
        return 'assets/images/backgrounds/squall.png';
      case 'thunderstorm':
        return 'assets/images/backgrounds/thunderstorm.png';
      case 'tornado':
        return 'assets/images/backgrounds/tornado.png';
      default:
        return 'assets/images/backgrounds/default.png';
    }
  }
}
