import 'dart:convert';

import '../model/api_response/login_response.dart';
import '../model/api_response/register_response.dart';

Future<LogInResponse> parseLogInResponse(String responseBody) async {
  return LogInResponse.fromJson(json.decode(responseBody));
}

Future<RegisterResponse> parseRegisterResponse(String responseBody) async {
  return RegisterResponse.fromJson(json.decode(responseBody));
}
