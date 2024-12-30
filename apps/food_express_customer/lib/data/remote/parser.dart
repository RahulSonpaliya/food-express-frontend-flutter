import 'dart:convert';

import '../model/api_response/login_response.dart';

Future<LogInResponse> parseLogInResponse(String responseBody) async {
  return LogInResponse.fromJson(json.decode(responseBody));
}
