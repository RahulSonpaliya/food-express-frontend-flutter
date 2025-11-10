import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart' hide showDialog;
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;
import 'package:shared/common_utils.dart';
import 'package:shared/data/local/app_shared_prefs.dart';
import 'package:shared/data/local/preference_keys.dart';
import 'package:shared/geocoding_utils.dart';
import 'package:shared/location_utils.dart';
import 'package:shared/secrets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/locator.dart';
import '../../../../../data/remote/repository.dart';

class AddNewAddressViewModel extends BaseViewModel {
  bool countryFound = false, stateFound = false;
  String? address1, address2, state, country, nickName, lat, lng;

  final _navigationService = locator.get<NavigationService>();
  final _snackBarService = locator.get<SnackbarService>();
  navigateBack() => _navigationService.back();

  updateNickName(String val) {
    nickName = val;
    notifyListeners();
  }

  getPlaceDetails(Prediction prediction) async {
    showLoading();
    GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: Google_API_KEY);
    PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(prediction.placeId ?? "");
    await _updateAllFields(
        prediction.description ?? "",
        detail.result.geometry?.location.lat ?? 0,
        detail.result.geometry?.location.lng ?? 0);
    await hideLoading();
  }

  checkLocationPermission3() async {
    permissionHandler.PermissionStatus? status;
    if (Platform.isAndroid) {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result = await [permissionHandler.Permission.location].request();
      status = result[permissionHandler.Permission.location];
    } else {
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus>
          result =
          await [permissionHandler.Permission.locationWhenInUse].request();
      status = result[permissionHandler.Permission.locationWhenInUse];
    }
    print("status $status");
    if (status == permissionHandler.PermissionStatus.granted) {
      getUserLocation();
    } else {
      var deniedPermanentAndroid = Platform.isAndroid &&
          status == permissionHandler.PermissionStatus.permanentlyDenied;
      var deniedPermanentIos =
          Platform.isIOS && status == permissionHandler.PermissionStatus.denied;
      if (deniedPermanentAndroid || deniedPermanentIos) {
        AppSharedPrefs.get()
            .getBoolean(PreferenceKeys.FIRST_TIME_ACCESS_LOCATION)
            .then((flag) {
          if (flag ?? true) {
            AppSharedPrefs.get()
                .addBoolean(PreferenceKeys.FIRST_TIME_ACCESS_LOCATION, false);
          } else {
            showDialog("Please allow location permission from settings.",
                okBtnClick: () {
              AppSettings.openAppSettings();
            }, cancelBtnTitle: 'Cancel');
          }
        });
      }
    }
  }

  getUserLocation() async {
    if (await LocationUtils.handlePermission()) {
      showLoading();
      var currentPosition = await LocationUtils.getCurrentPosition();
      debugPrint(
          'getUserLocation --------> currentPosition----> ${currentPosition?.toJson()}');
      if (currentPosition != null) {
        await _updateAllFields(
            null, currentPosition.latitude, currentPosition.longitude);
      }
      await hideLoading();
    }
  }

  _updateAllFields(String? address, double lat1, double lng1) async {
    var result = await GeocodingUtils.getPlacemarkFromCoordinates(lat1, lng1);
    if (result != null && result.isNotEmpty) {
      var currentAddress = result.first;
      address1 = address ?? currentAddress.street;
      // Note there are no lat, lon available in currentAddress.coordinates
      // lat =
      //     address != null ? '$lat1' : '${currentAddress.coordinates.latitude}';
      // lng =
      //     address != null ? '$lng1' : '${currentAddress.coordinates.longitude}';
      lat = lat1.toString();
      lng = lng1.toString();
      state = currentAddress.administrativeArea;
      country = currentAddress.country;
      stateFound = state != null;
      countryFound = country != null;
      notifyListeners();
    }
  }

  saveButtonClick() async {
    if (_validateInput()) {
      showLoading();
      var result = await locator<Repository>()
          .addAddress(requestBody: await _getRequestForAddAddress());
      await hideLoading();
      result.fold((failure) => showRetryDialog(failure: failure),
          (addAddressResponse) => _navigationService.back(result: true));
    }
  }

  Future<Map<String, String>> _getRequestForAddAddress() async {
    Map<String, String> request = {};
    request['city'] = state ?? "";
    request['country'] = country ?? "";
    request['address'] = address1 ?? "";
    request['address_2'] = address2 ?? "";
    request['address_nick_name'] = nickName ?? "";
    request['latitude'] = lat.toString();
    request['longitude'] = lng.toString();
    return request;
  }

  _validateInput() {
    if (address1?.isEmpty ?? true) {
      _snackBarService.showSnackbar(message: "Please enter address 1.");
      return false;
    }
    if (address2?.isEmpty ?? true) {
      _snackBarService.showSnackbar(message: "Please enter address 2.");
      return false;
    }
    if (state?.isEmpty ?? true) {
      _snackBarService.showSnackbar(message: "Please enter state.");
      return false;
    }
    if (country?.isEmpty ?? true) {
      _snackBarService.showSnackbar(message: "Please enter country.");
      return false;
    }
    if (nickName?.isEmpty ?? true) {
      _snackBarService.showSnackbar(
          message: "Please select nickname of your address.");
      return false;
    }
    return true;
  }
}
