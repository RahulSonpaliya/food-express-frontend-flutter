import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared/data/local/app_shared_prefs.dart';
import 'package:shared/data/local/preference_keys.dart';

ValueNotifier<User?> appUser = ValueNotifier<User?>(null);

class User {
  final num id;
  final String countryCode;
  final String phoneNumber;
  final String name;
  final String emailId;
  String profileImage;

  User({
    required this.id,
    required this.countryCode,
    required this.phoneNumber,
    required this.name,
    required this.emailId,
    required this.profileImage,
  });

  Map<String, dynamic> toJson(User obj) {
    return <String, dynamic>{
      'id': obj.id,
      'countryCode': obj.countryCode,
      'phoneNumber': obj.phoneNumber,
      'name': obj.name,
      'emailId': obj.emailId,
      'profileImage': obj.profileImage,
    };
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      id: parsedJson['id'],
      countryCode: parsedJson['countryCode'],
      phoneNumber: parsedJson['phoneNumber'],
      name: parsedJson['name'],
      emailId: parsedJson['emailId'],
      profileImage: parsedJson['profileImage'],
    );
  }

  static Future<void> saveUser(User user) async {
    var userBeanString = json.encode(user.toJson(user));
    await AppSharedPrefs.get()
        .addValue(PreferenceKeys.USER_DATA, userBeanString);
  }

  static Future<User> getSavedUser() async {
    String userString =
        await AppSharedPrefs.get().getValue(PreferenceKeys.USER_DATA) ?? '';
    Map<String, dynamic> userMap = json.decode(userString);
    return User.fromJson(userMap);
  }
}
