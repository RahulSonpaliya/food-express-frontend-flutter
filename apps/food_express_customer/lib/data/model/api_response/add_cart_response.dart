import 'base_response.dart';

class AddCartResponse extends BaseResponse {
  late num cartId;
  AddCartResponse({required super.message, required super.success});

  factory AddCartResponse.fromJson(Map<String, dynamic> parsedJson) {
    final message = parsedJson['message'] ?? '';
    final success = parsedJson['success'] ?? false;
    AddCartResponse addCartResponse =
        AddCartResponse(message: message, success: success);
    addCartResponse.cartId = parsedJson['cart_id'];
    return addCartResponse;
  }
}
