import '../bean/card.dart';
import 'base_response.dart';

class GetCardResponse extends BaseResponse {
  List<Card> cards = List.empty(growable: true);
  GetCardResponse({required super.success, required super.message});

  factory GetCardResponse.fromJson(Map<String, dynamic> parsedJson) {
    GetCardResponse res = GetCardResponse(
        message: parsedJson['message'], success: parsedJson['success']);
    var cardsJsonArray = parsedJson['data'] as List;
    List<Card> cardsList = cardsJsonArray.map((i) => Card.fromJson(i)).toList();
    res.cards = cardsList;
    return res;
  }
}
