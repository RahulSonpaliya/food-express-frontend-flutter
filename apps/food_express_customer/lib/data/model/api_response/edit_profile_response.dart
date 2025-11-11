import 'base_response.dart';

class EditProfileResponse extends BaseResponse {
  late String data;

  EditProfileResponse({required super.message, required super.success});

  factory EditProfileResponse.fromJson(Map<String, dynamic> parsedJson) {
    var message = parsedJson['message'] ?? '';
    var success = parsedJson['success'] ?? false;
    EditProfileResponse editProfileResponse =
        EditProfileResponse(message: message, success: success);
    editProfileResponse.data = parsedJson['data'];
    return editProfileResponse;
  }
}
