import '../bean/market.dart';
import '../bean/product.dart';
import 'base_response.dart';

class GetCartResponse extends BaseResponse {
  late num cartId;
  late Market? vendorDetail;
  late double deliveryPrice;
  late List<Product> products;

  GetCartResponse({required super.message, required super.success});

  factory GetCartResponse.fromJson(Map<String, dynamic> parsedJson) {
    final message = parsedJson['message'] ?? '';
    final success = parsedJson['success'] ?? false;
    GetCartResponse getCartRes =
        GetCartResponse(message: message, success: success);
    if (parsedJson['vendor_detail'] != null) {
      getCartRes.vendorDetail = Market.fromJson(parsedJson['vendor_detail']);
    }
    getCartRes.deliveryPrice = parsedJson['delivery_price'] ?? 0;
    getCartRes.cartId = parsedJson['cart_id'] ?? 0;
    var productsJsonArray = parsedJson['products'] as List;
    getCartRes.products = productsJsonArray
        .map((e) => Product.fromJson(e))
        .toList(growable: true);
    return getCartRes;
  }
}
