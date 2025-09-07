import '../bean/market.dart';
import '../bean/product.dart';
import 'base_response.dart';

class MarketDetailResponse extends BaseResponse {
  Market? market;
  List<Product> products = List.empty(growable: true);
  MarketDetailResponse({required super.message, required super.success});

  factory MarketDetailResponse.fromJson(Map<String, dynamic> parsedJson) {
    final message = parsedJson['message'] ?? '';
    final success = parsedJson['success'] ?? false;
    MarketDetailResponse res = MarketDetailResponse(
      message: message,
      success: success,
    );
    var productsDataObj = parsedJson['data'];
    var productsJsonArray = productsDataObj['products'] as List;
    List<Product> productsList =
        productsJsonArray.map((i) => Product.fromJson(i)).toList();
    res.products = productsList;
    res.market = Market.fromJson(parsedJson['data']);
    return res;
  }
}
