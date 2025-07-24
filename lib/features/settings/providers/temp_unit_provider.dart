/*
 * @Author: Bon Ryan
 * @Created: 2025-07-25
 * @Page: temp_unit_provider
 * @Description: This file contains the TempUnitProvider for managing temperature unit preferences.
 * It allows the user to switch between Celsius and Fahrenheit.
 * It is used to provide the current temperature unit to the application.
 * It is part of the settings feature and is used in the WeatherViewModel to format temperatures
 * according to the user's preference.
 * 
 * @usage:
 * final tempUnit = ref.watch(tempUnitProvider);
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TempUnit { celsius, fahrenheit }

class TempUnitNotifier extends AsyncNotifier<TempUnit> {
  static const _key = 'temp_unit';

  @override
  Future<TempUnit> build() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key) ?? 'celsius';
    return value == 'fahrenheit' ? TempUnit.fahrenheit : TempUnit.celsius;
  }

  Future<void> setUnit(TempUnit unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, unit == TempUnit.fahrenheit ? 'fahrenheit' : 'celsius');
    state = AsyncValue.data(unit);
  }
}

final tempUnitProvider = AsyncNotifierProvider<TempUnitNotifier, TempUnit>(TempUnitNotifier.new);
