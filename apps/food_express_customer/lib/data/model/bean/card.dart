class Card {
  num id, user_id, is_default;
  dynamic exp_month, exp_year;
  String card_id, card_holder, brand, last_four_digit;

  Card({this.id, this.user_id, this.is_default, this.card_id, this.card_holder, this.brand, this.exp_month, this.exp_year, this.last_four_digit});

  factory Card.fromJson(Map<String, dynamic> parsedJson) {
    return Card(
      id: parsedJson['id'],
      user_id: parsedJson['user_id'],
      is_default: parsedJson['is_default'],
      card_id: parsedJson['card_id'],
      card_holder: parsedJson['card_holder'],
      brand: parsedJson['brand'],
      exp_month: parsedJson['exp_month'],
      exp_year: parsedJson['exp_year'],
      last_four_digit: parsedJson['last_four_digit'],
    );
  }
}