import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/secrets.dart';
import 'package:stacked/stacked.dart';

import '../../data/model/bean/user_address.dart';

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
}
