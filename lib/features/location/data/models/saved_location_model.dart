/*
 * @Author: Bon Ryan
 * @Created: 2025-07-24
 * @Page: saved_location_model
 * @Description: This file defines the SavedLocationModel class for managing saved locations.
 * It extends the SavedLocation entity and provides methods for serialization and deserialization.
 * It is used to encapsulate the data structure for saved locations in the application.
 * It is part of the data layer and is used in conjunction with the LocationLocalDataSource class.
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
 * @dependencies: This class depends on the SavedLocation entity for its structure.
 * It requires the Hive package for serialization and deserialization of location data.
 * It is part of the location feature in the JustAWeather application.
 * It is used in conjunction with the LocationLocalDataSource class to provide a complete data access layer.
 * It is used to provide a local data source for the location feature in the JustAWeather application.
 */


import '../../domain/entities/saved_location.dart';

class SavedLocationModel extends SavedLocation {
 const SavedLocationModel({
    required super.id,
    required super.name,
    super.country,
    super.lat,
    super.lon,
  });

  factory SavedLocationModel.fromJson(Map<String, dynamic> json) =>
      SavedLocationModel(
        id: json['id'],
        name: json['name'],
        country: json['country'],
        lat: (json['lat'] as num?)?.toDouble(),
        lon: (json['lon'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country': country,
        'lat': lat,
        'lon': lon,
      };
}
