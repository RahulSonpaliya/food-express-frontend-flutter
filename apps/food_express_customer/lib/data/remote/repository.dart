import 'package:dartz/dartz.dart';
import 'package:shared/api_utils.dart';
import 'package:shared/data/remote/failure.dart';

import '../model/api_response/login_response.dart';
import 'parser.dart';

const String BASE_URL = "https://localhost:8080";
const String LOGIN_URL = BASE_URL + "/login";

Map<String, String> HEADER = {'Accept': 'application/json'};

abstract class Repository {
  Future<Either<Failure, LogInResponse>> logIn(
      {required Map<String, String> requestBody});
}

class Network extends Repository {
  @override
  Future<Either<Failure, LogInResponse>> logIn(
      {required Map<String, String> requestBody}) async {
    return await callPostAPI(LOGIN_URL, HEADER, parseLogInResponse,
        body: requestBody);
  }
}
