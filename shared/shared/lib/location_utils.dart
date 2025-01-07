import 'package:geolocator/geolocator.dart';
import 'package:shared/common_utils.dart' as common_utils;

class LocationUtils {
  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static final GeolocatorPlatform _geolocatorPlatform =
      GeolocatorPlatform.instance;

  static Future<Position?> getCurrentPosition() async =>
      await _geolocatorPlatform.getCurrentPosition();

  static Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      common_utils.showDialog(
        _kLocationServicesDisabledMessage,
        okBtnClick: _geolocatorPlatform.openLocationSettings,
      );
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        common_utils.showDialog(_kPermissionDeniedMessage);
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      common_utils.showDialog(
        _kPermissionDeniedForeverMessage,
        okBtnClick: _geolocatorPlatform.openAppSettings,
      );

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return true;
  }
}
