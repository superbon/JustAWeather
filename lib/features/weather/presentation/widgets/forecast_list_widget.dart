/*
 * @Author: Bon Ryan
 * @Created: 2025-07-24
 * @Page: forecast_list_widget
 * @Description: This file contains the ForecastListWidget class for displaying a list of weather forecasts.
 */
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justaweather/features/weather/domain/entities/forecast.dart';
import '../../../../shared/widgets/FrostedGlassCard.dart';



class ForecastListWidget extends StatelessWidget {
  final List<Forecast> forecasts;
  const ForecastListWidget(this.forecasts, {super.key});

  @override
  Widget build(BuildContext context) {
  return SizedBox(
  height: 170, // fixes card height!
  child: ListView.separated(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    itemCount: forecasts.length,
    separatorBuilder: (_, __) => const SizedBox(width: 16),
    itemBuilder: (context, index) {
      final f = forecasts[index];
      final dayString = DateFormat('E').format(f.date);

      return FrostedGlassCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayString,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
              ),
            ),
            const SizedBox(height: 10),
            Image.network(
              'https://openweathermap.org/img/wn/${f.icon}@2x.png',
              width: 36,
              height: 36,
              color: Colors.orangeAccent,
              errorBuilder: (context, _, __) => const Icon(Icons.cloud),
            ),
            const SizedBox(height: 10),
            Text(
              '${f.temperature.round()}°C',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                shadows: [Shadow(blurRadius: 4, color: Colors.black26)],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              f.condition,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                shadows: [Shadow(blurRadius: 4, color: Colors.black12)],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    },
  ),
);
}
}