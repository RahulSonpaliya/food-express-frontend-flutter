import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared/data/local/app_shared_prefs.dart';
import 'package:shared/data/local/preference_keys.dart';

ValueNotifier<UserAddress?> appUserAddress = ValueNotifier<UserAddress?>(null);

class UserAddress {
  String address;
  String latitude;
  String longitude;

  UserAddress({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson(UserAddress obj) {
    return <String, dynamic>{
      'address': obj.address,
      'latitude': obj.latitude,
      'longitude': obj.longitude,
    };
  }

  factory UserAddress.fromJson(Map<String, dynamic> parsedJson) {
    return UserAddress(
      address: parsedJson['address'],
      latitude: parsedJson['latitude'],
      longitude: parsedJson['longitude'],
    );
  }

  static Future<void> saveUserAddress(UserAddress user) async {
    var userBeanString = json.encode(user.toJson(user));
    await AppSharedPrefs.get()
        .addValue(PreferenceKeys.USER_ADDRESS_DATA, userBeanString);
  }

  static Future<UserAddress> getSavedUserAddress() async {
    String userString =
        await AppSharedPrefs.get().getValue(PreferenceKeys.USER_ADDRESS_DATA) ??
            '';
    Map<String, dynamic> userMap = json.decode(userString);
    return UserAddress.fromJson(userMap);
  }
}
