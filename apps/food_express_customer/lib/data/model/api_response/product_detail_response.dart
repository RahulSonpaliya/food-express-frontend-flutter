import '../bean/product.dart';
import 'base_response.dart';

class ProductDetailResponse extends BaseResponse {
  late Product product;
  ProductDetailResponse({required super.message, required super.success});

  factory ProductDetailResponse.fromJson(Map<String, dynamic> parsedJson) {
    final message = parsedJson['message'] ?? '';
    final success = parsedJson['success'] ?? false;
    ProductDetailResponse res = ProductDetailResponse(
      message: message,
      success: success,
    );
    res.product = Product.fromJson(parsedJson['product']);
    return res;
  }
}
