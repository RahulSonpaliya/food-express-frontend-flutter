import 'dart:convert';

import 'package:food_express_customer/data/model/api_response/base_response.dart';

import '../model/api_response/all_category_response.dart';
import '../model/api_response/login_response.dart';
import '../model/api_response/register_response.dart';

Future<LogInResponse> parseLogInResponse(String responseBody) async {
  return LogInResponse.fromJson(json.decode(responseBody));
}

Future<RegisterResponse> parseRegisterResponse(String responseBody) async {
  return RegisterResponse.fromJson(json.decode(responseBody));
}

Future<BaseResponse> parseBaseResponse(String responseBody) async {
  return BaseResponse.fromJson(json.decode(responseBody));
}

Future<AllCategoryResponse> parseAllCategoryResponse(
    String responseBody) async {
  return AllCategoryResponse.fromJson(json.decode(responseBody));
}
