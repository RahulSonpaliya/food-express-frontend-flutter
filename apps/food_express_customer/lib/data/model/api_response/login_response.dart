import '../bean/user.dart';
import 'base_response.dart';

class LogInResponse extends BaseResponse {
  late bool otpVerified;
  late num userId;
  User? user;
  LogInResponse({required super.success, required super.message});

  factory LogInResponse.fromJson(Map<String, dynamic> parsedJson) {
    final message = parsedJson['message'] ?? '';
    final success = parsedJson['success'] ?? false;
    final response = LogInResponse(message: message, success: success);
    response.otpVerified = parsedJson['otp_verified'];
    response.userId = parsedJson['user_id'];
    if (response.otpVerified) {
      response.user = User.fromJson(parsedJson['user']);
    }
    return response;
  }
}
