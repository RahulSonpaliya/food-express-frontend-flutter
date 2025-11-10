import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class GeocodingUtils {
  static Future<Location> getLocationFromAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    return locations[0];
  }

  static Future<List<Placemark>?> getPlacemarkFromCoordinates(
          double lat, double lng) async =>
      await placemarkFromCoordinates(lat, lng);

  static Future<String?> getCompleteAddressFromCoordinates(
      double lat, double lng) async {
    try {
      List<Placemark> placemarks =
          await getPlacemarkFromCoordinates(lat, lng) ?? [];
      debugPrint(
          'getCompleteAddressFromCoordinates --------> placemarks----> $placemarks');

      var address = '';

      if (placemarks.isNotEmpty) {
        // Concatenate non-null components of the address
        var streets = placemarks.reversed
            .map((placemark) => placemark.street)
            .where((street) => street != null);

        // Filter out unwanted parts
        streets = streets.where((street) =>
            street!.toLowerCase() !=
            placemarks.reversed.last.locality!
                .toLowerCase()); // Remove city names
        streets = streets
            .where((street) => !street!.contains('+')); // Remove street codes

        address += streets.join(', ');

        address += ', ${placemarks.reversed.last.subLocality ?? ''}';
        address += ', ${placemarks.reversed.last.locality ?? ''}';
        address += ', ${placemarks.reversed.last.subAdministrativeArea ?? ''}';
        address += ', ${placemarks.reversed.last.administrativeArea ?? ''}';
        address += ', ${placemarks.reversed.last.postalCode ?? ''}';
        address += ', ${placemarks.reversed.last.country ?? ''}';
      }
      return address;
    } catch (e) {
      debugPrint(
          'getCompleteAddressFromCoordinates --------> Exception----> $e');
      return null;
    }
  }
}
