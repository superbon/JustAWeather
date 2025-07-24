/*
 * @Author: Bon Ryan
 * @Created: 2025-07-24
 * @Page: saved_location
 * @Description: This file defines the SavedLocation entity for managing saved locations.
 * It includes properties for id, name, country, latitude, and longitude.
 * It is used to encapsulate the data structure for saved locations in the application.
 * It is part of the location domain layer and is used in conjunction with the LocationRepository interface.
 * It is used to provide a structured way to manage saved locations in the application.
 * It is used to interact with the local storage system to persist user-defined locations.
 * It is used to provide a consistent interface for location data operations.
 * 
 * @Usage: This class is used in the LocationRepositoryImp class to manage saved locations.
 * It is used to retrieve saved locations for display in the LocationListScreen.
 * It is used to add new locations when the user saves a location.
 * It is used to update existing locations when the user modifies them.
 * It is used to delete locations when the user removes them from the list.
 * It is used to ensure that the application can persist user-defined locations across sessions.
 * It is used to provide a local data source for the location feature in the application.
 * 
 * @dependencies: This class depends on the Equatable package for value equality.
 * It is part of the location feature in the JustAWeather application.
 * It is used in conjunction with the LocationRepository interface to provide a complete data access layer.
 * It is used to provide a local data source for the location feature in the JustAWeather application.
 */
import 'package:equatable/equatable.dart';

class SavedLocation extends Equatable {
  final String id; // UUID or timestamp-based
  final String name; // City or place
  final String? country; // Optional
  final double? lat; // Optional, if reverse geocoded
  final double? lon; // Optional

  const SavedLocation({
    required this.id,
    required this.name,
    this.country,
    this.lat,
    this.lon,
  });

  @override
  List<Object?> get props => [id, name, country, lat, lon];
}
