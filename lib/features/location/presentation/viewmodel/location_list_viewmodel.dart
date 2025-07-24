/*
 * @Author: Bon Ryan
 * @Created: 2025-07-24
 * @Page: location_list_viewmodel
 * @Description: This file defines the LocationListViewModel used in the location feature.
 * It manages the state of the list of saved locations and provides methods to load, add,
 * update, and delete locations. It uses the LocationRepository to interact with the data layer.
 * It is part of the presentation layer and is used to encapsulate the logic for managing
 * saved locations in the application. It is used to provide a structured way to manage
 * saved locations in the application. It is used to interact with the local storage system
 * to persist user-defined locations. It is used to provide a consistent interface for
 * location data operations.
 * 
 * @Usage: This class is used in the LocationListScreen to manage the state of saved locations.
 * It is used to retrieve saved locations for display in the list. It is used to add
 * new locations when the user saves a location. It is used to update existing locations
 * when the user modifies them. It is used to delete locations when the user removes them
 * from the list. It is used to ensure that the application can persist user-defined locations
 * across sessions. It is used to provide a local data source for the location feature in the
 * application.
 * 
 * @dependencies: This class depends on the Riverpod package for state management.
 * It requires the LocationRepository interface for data access. It is part of the location
 * feature in the JustAWeather application. It is used in conjunction with the LocationRepository
 * interface to provide a complete data access layer. It is used to provide a local data source
 * for the location feature in the JustAWeather application.
 * 
 */
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/saved_location.dart';
import '../../domain/repositories/location_repository.dart';
import '../../data/repositories/location_repository_imp.dart';
import '../../data/datasources/location_local_datasource.dart';

class LocationListViewModel extends StateNotifier<AsyncValue<List<SavedLocation>>> {
  final LocationRepository repository;

  LocationListViewModel(this.repository) : super(const AsyncValue.loading()) {
    loadLocations();
  }

  Future<void> loadLocations() async {
    state = const AsyncValue.loading();
    try {
      final locations = await repository.getLocations();
      state = AsyncValue.data(locations);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addLocation(SavedLocation location) async {
    await repository.addLocation(location);
    await loadLocations();
  }

  Future<void> updateLocation(SavedLocation location) async {
    await repository.updateLocation(location);
    await loadLocations();
  }

  Future<void> deleteLocation(String id) async {
    await repository.deleteLocation(id);
    await loadLocations();
  }
}

// Provider for use in widgets
final locationListViewModelProvider = StateNotifierProvider<LocationListViewModel, AsyncValue<List<SavedLocation>>>(
  (ref) => LocationListViewModel(
    LocationRepositoryImp(LocationLocalDataSource()),
  ),
);
