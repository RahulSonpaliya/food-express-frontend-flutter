import 'base_response.dart';

class LogInResponse extends BaseResponse {
  LogInResponse({required super.success, required super.message});

  factory LogInResponse.fromJson(Map<String, dynamic> parsedJson) {
    final message = parsedJson['message'] ?? '';
    final success = parsedJson['success'] ?? false;
    return LogInResponse(message: message, success: success);
  }
}
