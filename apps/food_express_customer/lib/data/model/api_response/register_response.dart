import 'base_response.dart';

class RegisterResponse extends BaseResponse {
  late bool otpVerified;
  late num userId;
  RegisterResponse({required super.success, required super.message});

  factory RegisterResponse.fromJson(Map<String, dynamic> parsedJson) {
    final message = parsedJson['message'] ?? '';
    final success = parsedJson['success'] ?? false;
    final response = RegisterResponse(message: message, success: success);
    response.otpVerified = parsedJson['otpVerified'];
    response.userId = parsedJson['userId'];
    return response;
  }
}
