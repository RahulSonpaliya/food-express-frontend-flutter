import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'data/remote/failure.dart';

const Duration API_TIME_OUT = Duration(seconds: 60);

Future<Either<Failure, Q>> callPostAPI<Q, R>(String apiURL,
    Map<String, String> headers, ComputeCallback<String, R> callback,
    {body}) async {
  try {
    debugPrint('apiURL : $apiURL');
    debugPrint('headers : $headers');
    debugPrint('body : $body');
    http.Response response = await http
        .post(Uri.parse(apiURL), headers: headers, body: jsonEncode(body))
        .timeout(API_TIME_OUT);
    return parseResponse(response, callback);
  } on SocketException {
    return Left(NoInternetError(0,
        'Network error: Unable to connect to the server. Please check your internet connection or try again later.'));
  } on TimeoutException {
    return Left(TimeoutError(0, 'request time out'));
  }
}

Future<Either<Failure, Q>> callPostAPIMultiPart<Q, R>(String apiURL,
    Map<String, String> headers, ComputeCallback<String, R> callback,
    {required Map<String, String> body,
    required Map<String, String> files}) async {
  try {
    debugPrint('apiURL : $apiURL');
    debugPrint('headers : $headers');
    debugPrint('body : $body');
    debugPrint('files : $files');
    var request = new http.MultipartRequest("POST", Uri.parse(apiURL));
    headers.forEach((k, v) => request.headers[k] = v);
    body.forEach((k, v) => request.fields[k] = v);
    files.forEach((k, v) async {
      request.files.add(await http.MultipartFile.fromPath(k, v));
    });
    var response = await request.send().timeout(API_TIME_OUT);
    return parseResponse(await http.Response.fromStream(response), callback);
  } on SocketException {
    return Left(NoInternetError(0,
        'something went wrong while connecting to server! Please try again later.'));
  } on TimeoutException {
    return Left(TimeoutError(0, 'request time out'));
  }
}

Future<Either<Failure, Q>> callGetAPI<Q, R>(String apiURL,
    Map<String, String> headers, ComputeCallback<String, R> callback) async {
  try {
    debugPrint('apiURL : $apiURL');
    debugPrint('headers : $headers');
    http.Response response = await http
        .get(Uri.parse(apiURL), headers: headers)
        .timeout(API_TIME_OUT);
    return parseResponse(response, callback);
  } on SocketException {
    return Left(NoInternetError(0,
        'something went wrong while connecting to server! Please try again later.'));
  } on TimeoutException {
    return Left(TimeoutError(0, 'request time out'));
  }
}

Future<Either<Failure, Q>> callDeleteAPI<Q, R>(String apiURL,
    Map<String, String> headers, ComputeCallback<String, R> callback) async {
  try {
    debugPrint('apiURL : $apiURL');
    debugPrint('headers : $headers');

    http.Response response = await http
        .delete(Uri.parse(apiURL), headers: headers)
        .timeout(API_TIME_OUT);
    return parseResponse(response, callback);
  } on SocketException {
    return Left(NoInternetError(0,
        'something went wrong while connecting to server! Please try again later.'));
  } on TimeoutException {
    return Left(TimeoutError(0, 'request time out'));
  }
}

Future<Either<Failure, Q>> callPutAPI<Q, R>(String apiURL,
    Map<String, String> headers, ComputeCallback<String, R> callback,
    {body}) async {
  try {
    debugPrint('apiURL : $apiURL');
    debugPrint('headers : $headers');
    debugPrint('body : $body');
    http.Response response = await http
        .put(Uri.parse(apiURL), headers: headers, body: body)
        .timeout(API_TIME_OUT);
    return parseResponse(response, callback);
  } on SocketException {
    return Left(NoInternetError(0,
        'something went wrong while connecting to server! Please try again later.'));
  } on TimeoutException {
    return Left(TimeoutError(0, 'request time out'));
  }
}

Future<Either<Failure, Q>> parseResponse<Q, R>(
    http.Response? response, ComputeCallback<String, R> callback) async {
  if (response == null) {
    debugPrint('response is null');
    return Left(UnknownError(0, 'unknown'));
  } else {
    debugPrint(
        'response.statusCode : ${response.statusCode} | response.body ${response.body}');
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        bool success = json.decode(response.body)['success'];
        if (success) {
          var result = await compute(callback, response.body);
          return Right(result as Q);
        } else {
          var errorObj = json.decode(response.body)['error'];
          var errorMsg = errorObj['message'];
          return Left(ServerError(response.statusCode, errorMsg));
        }
      } else {
        var errorObj = json.decode(response.body);
        var errorMsg = errorObj['errorMessage'];
        return Left(ServerError(response.statusCode, errorMsg));
      }
    } catch (e) {
      return Left(UnknownError(0, 'unknown'));
    }
  }
}
