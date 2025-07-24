/*
 * @Author: Bon Ryan
 * @Created: 2025-07-24
 * @Page: location_repository_imp
 * @Description: This file implements the LocationRepository interface for managing saved locations.
 * It provides methods to get, add, update, and delete saved locations from local storage.
 * It uses the LocationLocalDataSource class to interact with Hive for local storage.
 * It is part of the data layer and is used to encapsulate the logic for accessing and manipulating saved locations.
 * It is used to provide a structured way to manage saved locations in the application.
 * It is used to interact with the local storage system to persist user-defined locations.
 * It is used to provide a consistent interface for location data operations.
 * 
 * @Usage: This class is used in the LocationListScreen to manage saved locations.
 * It is used to retrieve saved locations for display in the list.
 * It is used to add new locations when the user saves a location.
 * It is used to update existing locations when the user modifies them.
 * It is used to delete locations when the user removes them from the list.
 * It is used to ensure that the application can persist user-defined locations across sessions.
 * It is used to provide a local data source for the location feature in the application.
 * 
 * @dependencies: This class depends on the LocationLocalDataSource for local storage operations.
 * It requires the SavedLocationModel class for serialization and deserialization of location data. 
 * It is part of the location feature in the JustAWeather application.
 * It is used in conjunction with the LocationRepository interface to provide a complete data access layer.
 */


import '../../domain/entities/saved_location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_local_datasource.dart';
import '../models/saved_location_model.dart';

class LocationRepositoryImp implements LocationRepository {
  final LocationLocalDataSource localDataSource;

  LocationRepositoryImp(this.localDataSource);

  @override
  Future<List<SavedLocation>> getLocations() async {
    return await localDataSource.getLocations();
  }

  @override
  Future<void> addLocation(SavedLocation location) async {
    await localDataSource.addLocation(SavedLocationModel(
      id: location.id,
      name: location.name,
      country: location.country,
      lat: location.lat,
      lon: location.lon,
    ));
  }

  @override
  Future<void> updateLocation(SavedLocation location) async {
    await localDataSource.updateLocation(SavedLocationModel(
      id: location.id,
      name: location.name,
      country: location.country,
      lat: location.lat,
      lon: location.lon,
    ));
  }

  @override
  Future<void> deleteLocation(String id) async {
    await localDataSource.deleteLocation(id);
  }
}
