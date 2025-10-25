import 'package:dartz/dartz.dart';
import 'package:food_express_customer/data/model/api_response/base_response.dart';
import 'package:food_express_customer/data/model/api_response/nearby_markets_response.dart';
import 'package:food_express_customer/data/model/bean/user.dart';
import 'package:shared/api_utils.dart';
import 'package:shared/data/remote/failure.dart';

import '../model/api_response/all_category_response.dart';
import '../model/api_response/login_response.dart';
import '../model/api_response/market_detail_response.dart';
import '../model/api_response/product_detail_response.dart';
import '../model/api_response/register_response.dart';
import 'parser.dart';

const String BASE_URL = "http://localhost:8080";
const String LOGIN_URL = BASE_URL + "/users/login";
const String REGISTER_URL = BASE_URL + "/users/register";
const String VERIFY_OTP_URL = BASE_URL + "/users/verifyOtp";
const String RESEND_OTP_URL = BASE_URL + "/users/resendOtp";
const String RESET_PASSWORD_URL = BASE_URL + "/users/resetPassword";
const String GET_ALL_CATEGORIES_URL = BASE_URL + "/categories/get";
const String CATEGORY_ICON_URL = BASE_URL + "/categories/download/";
const String NEARBY_MARKETS_URL = BASE_URL + "/markets/nearby";
const String MARKET_DETAIL_URL = BASE_URL + "/markets/detail";
const String PRODUCT_DETAIL_URL = BASE_URL + "/products/detail";

Map<String, String> HEADER = {'Content-Type': 'application/json'};

abstract class Repository {
  Future<Map> getHeaderForAuthUser() async {
    return {
      'Content-Type': 'application/json',
      "User-Id": (await User.getSavedUser()).id,
    };
  }

  Future<Either<Failure, LogInResponse>> logIn(
      {required Map<String, String> requestBody});

  Future<Either<Failure, RegisterResponse>> signUp(
      {required Map<String, String> requestBody});

  Future<Either<Failure, BaseResponse>> verifyOtp(
      {required Map<String, String> requestBody});

  Future<Either<Failure, BaseResponse>> resendOtp(
      {required Map<String, String> requestBody});

  Future<Either<Failure, BaseResponse>> resetPassword(
      {required Map<String, String> requestBody});

  Future<Either<Failure, AllCategoryResponse>> getAllCategories();

  Future<Either<Failure, NearbyMarketResponse>> getNearbyMarkets(
      {required Map<String, String> requestBody});

  Future<Either<Failure, MarketDetailResponse>> getMarketDetail(num marketId,
      {num categoryId = -1});

  Future<Either<Failure, ProductDetailResponse>> getProductDetail(
      num productId);
}

class Network extends Repository {
  @override
  Future<Either<Failure, LogInResponse>> logIn(
      {required Map<String, String> requestBody}) async {
    return await callPostAPI(LOGIN_URL, HEADER, parseLogInResponse,
        body: requestBody);
  }

  @override
  Future<Either<Failure, RegisterResponse>> signUp(
      {required Map<String, String> requestBody}) async {
    return await callPostAPI(REGISTER_URL, HEADER, parseRegisterResponse,
        body: requestBody);
  }

  @override
  Future<Either<Failure, BaseResponse>> verifyOtp(
      {required Map<String, String> requestBody}) async {
    return await callPostAPI(VERIFY_OTP_URL, HEADER, parseBaseResponse,
        body: requestBody);
  }

  @override
  Future<Either<Failure, BaseResponse>> resendOtp(
      {required Map<String, String> requestBody}) async {
    return await callPostAPI(RESEND_OTP_URL, HEADER, parseBaseResponse,
        body: requestBody);
  }

  @override
  Future<Either<Failure, BaseResponse>> resetPassword(
      {required Map<String, String> requestBody}) async {
    return await callPostAPI(RESET_PASSWORD_URL, HEADER, parseBaseResponse,
        body: requestBody);
  }

  @override
  Future<Either<Failure, AllCategoryResponse>> getAllCategories() async {
    return await callGetAPI(
        GET_ALL_CATEGORIES_URL, HEADER, parseAllCategoryResponse);
  }

  @override
  Future<Either<Failure, NearbyMarketResponse>> getNearbyMarkets(
      {required Map<String, String> requestBody}) async {
    return await callPostAPI(
      NEARBY_MARKETS_URL,
      HEADER,
      parseNearbyMarketResponse,
      body: requestBody,
    );
  }

  @override
  Future<Either<Failure, MarketDetailResponse>> getMarketDetail(num marketId,
      {num categoryId = -1}) async {
    var url = '$MARKET_DETAIL_URL/$marketId?category_id=$categoryId';
    return await callGetAPI(url, HEADER, parseMarketDetailResponse);
  }

  @override
  Future<Either<Failure, ProductDetailResponse>> getProductDetail(
      num productId) async {
    return await callGetAPI(
      '$PRODUCT_DETAIL_URL/$productId',
      HEADER,
      parseProductDetailResponse,
    );
  }
}
