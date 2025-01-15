import '../bean/market.dart';
import 'base_response.dart';

class NearbyMarketResponse extends BaseResponse {
  List<Market> marketList = List.empty(growable: true);

  NearbyMarketResponse({required super.success, required super.message});

  factory NearbyMarketResponse.fromJson(Map<String, dynamic> parsedJson) {
    final message = parsedJson['message'] ?? '';
    final success = parsedJson['success'] ?? false;
    NearbyMarketResponse nearbyMarketResponse =
        NearbyMarketResponse(message: message, success: success);
    var marketList = parsedJson["marketList"] as List;
    nearbyMarketResponse.marketList =
        marketList.map((e) => Market.fromJson(e)).toList(growable: true);
    return nearbyMarketResponse;
  }
}
