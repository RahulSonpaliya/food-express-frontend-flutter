import '../bean/address.dart';
import 'base_response.dart';

class GetAddressListResponse extends BaseResponse {
  List<AddressBean> addressBeanList = List.empty(growable: true);

  GetAddressListResponse({required super.success, required super.message});

  factory GetAddressListResponse.fromJson(Map<String, dynamic> parsedJson) {
    final message = parsedJson['message'] ?? '';
    final success = parsedJson['success'] ?? false;
    GetAddressListResponse getAddressListResponse =
        GetAddressListResponse(message: message, success: success);
    var list = parsedJson['data'] as List;
    List<AddressBean> data = list.map((i) => AddressBean.fromJson(i)).toList();
    getAddressListResponse.addressBeanList = data;
    return getAddressListResponse;
  }
}
