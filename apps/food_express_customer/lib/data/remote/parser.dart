import 'dart:convert';

import 'package:food_express_customer/data/model/api_response/base_response.dart';

import '../model/api_response/add_address_response.dart';
import '../model/api_response/add_cart_response.dart';
import '../model/api_response/all_category_response.dart';
import '../model/api_response/edit_profile_response.dart';
import '../model/api_response/get_address_list_response.dart';
import '../model/api_response/get_cart_response.dart';
import '../model/api_response/get_delivery_charges_res.dart';
import '../model/api_response/login_response.dart';
import '../model/api_response/market_detail_response.dart';
import '../model/api_response/nearby_markets_response.dart';
import '../model/api_response/product_detail_response.dart';
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

Future<NearbyMarketResponse> parseNearbyMarketResponse(
    String responseBody) async {
  return NearbyMarketResponse.fromJson(json.decode(responseBody));
}

Future<MarketDetailResponse> parseMarketDetailResponse(
    String responseBody) async {
  return MarketDetailResponse.fromJson(json.decode(responseBody));
}

Future<ProductDetailResponse> parseProductDetailResponse(
    String responseBody) async {
  return ProductDetailResponse.fromJson(json.decode(responseBody));
}

Future<AddCartResponse> parseAddCartResponse(String responseBody) async {
  return AddCartResponse.fromJson(json.decode(responseBody));
}

Future<GetCartResponse> parseGetCartResponse(String responseBody) async {
  return GetCartResponse.fromJson(json.decode(responseBody));
}

Future<GetAddressListResponse> parseGetAddressListResponse(
    String responseBody) async {
  return GetAddressListResponse.fromJson(json.decode(responseBody));
}

Future<AddAddressResponse> parseAddAddressResponse(String responseBody) async {
  return AddAddressResponse.fromJson(json.decode(responseBody));
}

Future<GetDeliveryChargesRes> parseGetDeliveryChargesRes(
    String responseBody) async {
  return GetDeliveryChargesRes.fromJson(json.decode(responseBody));
}

Future<EditProfileResponse> parseEditProfileResponse(
    String responseBody) async {
  return EditProfileResponse.fromJson(json.decode(responseBody));
}
