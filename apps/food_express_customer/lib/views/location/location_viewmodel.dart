import 'package:flutter/cupertino.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:get/get.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/geocoding_utils.dart';
import 'package:shared/location_utils.dart';
import 'package:shared/secrets.dart';
import 'package:stacked/stacked.dart';

import '../../data/model/bean/user_address.dart';
import '../main/main_view.dart';

class LocationViewModel extends BaseViewModel {
  String addressVal = '';

  getPlaceDetails(Prediction prediction) async {
    if (prediction.placeId != null) {
      showLoading();
      GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: Google_API_KEY);
      PlacesDetailsResponse detail = await places.getDetailsByPlaceId(
        prediction.placeId!,
      );
      await _updateAddressLatLng(
        prediction.description ?? '',
        detail.result.geometry?.location.lat ?? 0.0,
        detail.result.geometry?.location.lng ?? 0.0,
      );
      hideLoading();
    }
  }

  _updateAddressLatLng(String address, double lat, double lng) async {
    addressVal = address;
    notifyListeners();
    UserAddress userAddressBean = UserAddress(
      address: addressVal,
      latitude: lat.toString(),
      longitude: lng.toString(),
    );
    await UserAddress.saveUserAddress(userAddressBean);
    appUserAddress.value = await UserAddress.getSavedUserAddress();
    appUserAddress.notifyListeners();
  }

  getUserLocation() async {
    if (await LocationUtils.handlePermission()) {
      showLoading();
      var currentPosition = await LocationUtils.getCurrentPosition();
      debugPrint(
          'getUserLocation --------> currentPosition----> ${currentPosition?.toJson()}');
      if (currentPosition != null) {
        final address = await GeocodingUtils.getCompleteAddressFromCoordinates(
          currentPosition.latitude,
          currentPosition.longitude,
        );
        debugPrint('getUserLocation --------> address----> $address');
        if (address != null) {
          await _updateAddressLatLng(
            address,
            currentPosition.latitude,
            currentPosition.longitude,
          );
        }
      }
      hideLoading();
    }
  }

  navigateToHome() {
    Get.offAll(() => const MainView(), transition: Transition.rightToLeft);
  }

  navigateBack() => Get.back();
}
