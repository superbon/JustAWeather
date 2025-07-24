/*
 * @Author: Bon Ryan
 * @Created: 2025-07-24
 * @Page: location_repository
 * @Description: This file defines the LocationRepository interface for managing saved locations.
 * It declares methods for getting, adding, updating, and deleting saved locations.
 * It is part of the domain layer and is implemented by the LocationRepositoryImp class.
 * It is used to abstract the data source layer from the domain layer.
 * It allows for easy testing and mocking of location data operations.
 * 
 * @Usage: This interface is used in the LocationRepositoryImp class to manage saved locations.
 * It is used to retrieve saved locations for display in the LocationListScreen.
 * It is used to add new locations when the user saves a location.
 * It is used to update existing locations when the user modifies them.
 * It is used to delete locations when the user removes them from the list.
 * It is used to ensure that the application can persist user-defined locations across sessions.
 * It is used to provide a local data source for the location feature in the application.
 * 
 * @dependencies: This interface does not depend on any external packages.
 * It is part of the location feature in the JustAWeather application.
 * It is used in conjunction with the LocationRepositoryImp class to provide a complete data access layer.
 * It is used to provide a local data source for the location feature in the JustAWeather
 * 
 */
import '../entities/saved_location.dart';

abstract class LocationRepository {
  Future<List<SavedLocation>> getLocations();
  Future<void> addLocation(SavedLocation location);
  Future<void> updateLocation(SavedLocation location);
  Future<void> deleteLocation(String id);
}
