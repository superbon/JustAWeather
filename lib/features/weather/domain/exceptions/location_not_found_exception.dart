/*
 * @Author: Bon Ryan
 * @Created: 2025-07-23
 * @Page: location_not_found_exception
 * @Description: This file defines the LocationNotFoundException used in the weather domain.
 * It is thrown when a location cannot be found during weather data retrieval.
 * It extends the base Exception class and provides a custom error message.
 * It is used to handle errors related to location not found scenarios in the weather domain.
 * It is part of the weather domain layer and helps in error handling.
 */

class LocationNotFoundException implements Exception {
  final String message;

  LocationNotFoundException([this.message = 'Location not found']);

  @override
  String toString() {
    return message;
  }
}