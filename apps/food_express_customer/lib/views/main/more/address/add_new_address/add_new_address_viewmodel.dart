import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:stacked/stacked.dart';
import 'package:vinedress_customer/app/api_failure_mixin.dart';
import 'package:vinedress_customer/data/remote/repository.dart';
import 'package:vinedress_customer/main.i18n.dart';
import 'package:vinedress_customer/utils/app_constants.dart';
import 'package:location/location.dart' as abc;
import 'package:vinedress_customer/data/local/app_shared_prefs.dart';
import 'package:vinedress_customer/data/local/preference_keys.dart';
import 'package:permission_handler/permission_handler.dart' as permissionHandler;

class AddNewAddressViewModel extends BaseViewModel with ApiFailureMixin {
  bool countryFound = false, stateFound = false;
  String address1, address2, state, country, nickName, lat, lng;

  navigateBack() => navService().back();

  updateNickName(String val) {
    nickName = val;
    notifyListeners();
  }

  getPlaceDetails(Prediction prediction) async {
    showLoading();
    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: Google_API_KEY);
    PlacesDetailsResponse _detail =
        await _places.getDetailsByPlaceId(prediction.placeId);
    await _updateAllFields(
        prediction.description,
        _detail.result.geometry.location.lat,
        _detail.result.geometry.location.lng);
    await hideLoading();
  }

  checkLocationPermission3() async {
    permissionHandler.PermissionStatus status;
    if(Platform.isAndroid){
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus> result = await [permissionHandler.Permission.location].request();
      status = result[permissionHandler.Permission.location];
    }else{
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus> result = await [permissionHandler.Permission.locationWhenInUse].request();
      status = result[permissionHandler.Permission.locationWhenInUse];
    }
    print("status $status");
    if (status == permissionHandler.PermissionStatus.granted) {
      getUserLocation();
    } else {
      var deniedPermanentAndroid = Platform.isAndroid && status == permissionHandler.PermissionStatus.permanentlyDenied;
      var deniedPermanentIos = Platform.isIOS && status == permissionHandler.PermissionStatus.denied;
      if(deniedPermanentAndroid || deniedPermanentIos){
        AppSharedPrefs.get()
          .getBoolean(PreferenceKeys.FIRST_TIME_ACCESS_LOCATION)
          .then(
          (flag) {
            if(flag ?? true) {
              AppSharedPrefs.get().addBoolean(PreferenceKeys.FIRST_TIME_ACCESS_LOCATION, false);
            }else{
              showDialog2(
                "Please allow location permission from settings.",
                okBtnClick: () {
                  AppSettings.openAppSettings();
                },
                cancelBtnTitle: 'Cancel'
              );
            }
          }
        );
      }
    }
  }

  getUserLocation() async {
    showLoading();
    var location = new abc.Location();
    var locationEnabled = await location.serviceEnabled();
    if (locationEnabled) {
      var currentLocation = await location.getLocation();
      await _updateAllFields(
          null, currentLocation.latitude, currentLocation.longitude);
      await hideLoading();
    } else {
      await hideLoading();
      showDialog2(
        'Unable to obtain your location, please enable gps from settings.',
        okBtnClick: () {
          AppSettings.openLocationSettings();
        },
        cancelBtnTitle: "Cancel",
      );
    }
  }

  _updateAllFields(String address, double lat1, double lng1) async {
    var result = await Geocoder.google(Google_API_KEY)
        .findAddressesFromCoordinates(Coordinates(lat1, lng1));
    if (result != null && result.isNotEmpty) {
      var currentAddress = result.first;
      address1 = address ?? currentAddress.addressLine;
      lat =
          address != null ? '$lat1' : '${currentAddress.coordinates.latitude}';
      lng =
          address != null ? '$lng1' : '${currentAddress.coordinates.longitude}';
      state = currentAddress.adminArea;
      country = currentAddress.countryName;
      stateFound = state != null;
      countryFound = country != null;
      notifyListeners();
    }
  }

  saveButtonClick() async {
    if (_validateInput()) {
      showLoading();
      var result = await Repository.get()
          .addAddress(requestBody: await _getRequestForAddAddress());
      await hideLoading();
      result.fold((failure) => showRetryDialog(failure: failure),
          (addAddressResponse) => navService().back(result: true));
    }
  }

  Future<Map<String, String>> _getRequestForAddAddress() async {
    Map<String, String> request = Map();
    request['city'] = state;
    request['country'] = country;
    request['address'] = address1;
    request['address_2'] = address2;
    request['address_nick_name'] = nickName;
    request['latitude'] = lat;
    request['longitude'] = lng;
    return request;
  }

  _validateInput() {
    if (address1?.isEmpty ?? true) {
      showSnackBar("Please enter address 1.".getString);
      return false;
    }
    if (address2?.isEmpty ?? true) {
      showSnackBar("Please enter address 2.".getString);
      return false;
    }
    if (state?.isEmpty ?? true) {
      showSnackBar("Please enter state.".getString);
      return false;
    }
    if (country?.isEmpty ?? true) {
      showSnackBar("Please enter country.".getString);
      return false;
    }
    if (nickName?.isEmpty ?? true) {
      showSnackBar("Please select nickname of your address.".getString);
      return false;
    }
    return true;
  }
}
