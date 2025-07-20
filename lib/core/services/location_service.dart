/*
 * @Author: Bon Ryan
 * @Created: 2025-07-21
 * @Page: location_service
 * @Description: This file defines the LocationService class for managing location-related operations.
 * It provides methods to get the current location of the user and to check if location services are enabled.
 * It uses the Geolocator package to access the device's location services.
 * It is part of the core services layer and can be used by various features that require location data.
 * It is used in the WeatherViewModel to fetch weather data based on the user's current location.
 * It is used to encapsulate the logic for accessing and managing location data.
 * It is used in the WeatherRepositoryImp class to return weather data based on the user's location
 */
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<bool> requestPermissionIfNeeded() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permission permanently denied.');
    }

    return true;
  }

  static Future<Position> getCurrentPosition() async {
    await requestPermissionIfNeeded();
    return await Geolocator.getCurrentPosition();
  }

  static Future<String> getCityFromCoordinates(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      return placemarks.first.locality ?? 'Unknown City';
    } else {
      throw Exception('City not found');
    }
  }

  static Future<String> getCurrentCity() async {
  try {
    final position = await getCurrentPosition();
    print("Position: ${position.latitude}, ${position.longitude}");

    final city = await getCityFromCoordinates(position);
    print("City: $city");

    return city;
  } catch (e) {
    print('getCurrentCity error: $e');
    rethrow;
  }
}
}