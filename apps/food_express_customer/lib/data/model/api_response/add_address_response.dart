import '../bean/address.dart';
import 'base_response.dart';

class AddAddressResponse extends BaseResponse {
  AddressBean addressBean = AddressBean();

  AddAddressResponse({required super.success, required super.message});

  factory AddAddressResponse.fromJson(Map<String, dynamic> parsedJson) {
    final message = parsedJson['message'] ?? '';
    final success = parsedJson['success'] ?? false;
    AddAddressResponse addAddressResponse =
        AddAddressResponse(message: message, success: success);
    if (parsedJson['data'] != null) {
      addAddressResponse.addressBean = AddressBean.fromJson(parsedJson['data']);
    }
    return addAddressResponse;
  }
}
