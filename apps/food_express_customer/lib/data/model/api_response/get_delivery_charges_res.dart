import 'base_response.dart';

class GetDeliveryChargesRes extends BaseResponse {
  num deliveryCharge = 0;
  GetDeliveryChargesRes({required super.success, required super.message});

  factory GetDeliveryChargesRes.fromJson(Map<String, dynamic> parsedJson) {
    final message = parsedJson['message'] ?? '';
    final success = parsedJson['success'] ?? false;
    GetDeliveryChargesRes response =
        GetDeliveryChargesRes(message: message, success: success);
    response.deliveryCharge = parsedJson['data'];
    return response;
  }
}
