/*
 * @Author: Bon Ryan
 * @Created: 2025-07-24
 * @Page: location_local_datasource
 * @Description: This file defines the LocationLocalDataSource class for managing saved locations.
 * It provides methods to get, add, update, and delete saved locations from local storage.
 * It uses Hive for local storage and is part of the data layer.
 * It is used to encapsulate the logic for accessing and manipulating saved locations.
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
 * @dependencies: This class depends on the Hive package for local storage.
 * It requires the SavedLocationModel class for serialization and deserialization of location data.
 * It is part of the location feature in the JustAWeather application.
 * It is used in conjunction with the LocationRepository interface to provide a complete data access layer.
 * It is used to provide a local data source for the location feature in the JustAWeather
 */

import 'package:hive/hive.dart';
import '../models/saved_location_model.dart';

class LocationLocalDataSource {
  static const _boxName = 'saved_locations_box';

  Future<List<SavedLocationModel>> getLocations() async {
    final box = await Hive.openBox(_boxName);
    return box.values
        .map((e) => SavedLocationModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> addLocation(SavedLocationModel location) async {
    final box = await Hive.openBox(_boxName);
    await box.put(location.id, location.toJson());
  }

  Future<void> updateLocation(SavedLocationModel location) async {
    final box = await Hive.openBox(_boxName);
    await box.put(location.id, location.toJson());
  }

  Future<void> deleteLocation(String id) async {
    final box = await Hive.openBox(_boxName);
    await box.delete(id);
  }
}
