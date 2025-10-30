import 'product_option.dart';

class Product {
  num id = 0;
  num? market_id = 0;
  String? image = '';
  String? description = '';
  String? imageAsset = '';
  String name = '';
  num price = 0;
  String? qty = '';
  List<ProductOption>? options = List.empty(growable: true);
  Product({
    required this.id,
    this.image,
    this.description,
    this.imageAsset,
    required this.name,
    required this.price,
    this.qty,
    this.options,
    this.market_id,
  });

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    var p = Product(
      id: parsedJson['id'],
      name: parsedJson['name'],
      image: parsedJson['image'],
      price: parsedJson['price'],
      market_id: parsedJson['market_id'],
      description: parsedJson['description'],
      qty: parsedJson['qty'],
    );
    if (parsedJson['product_option'] != null) {
      var optionsJsonArray = parsedJson['product_option'] as List;
      List<ProductOption> optionsList =
          optionsJsonArray.map((i) => ProductOption.fromJson(i)).toList();
      p.options = optionsList;
    }
    return p;
  }

  static var dummyProducts = [
    Product(
      id: 1,
      imageAsset: 'assets/dummy_product_2.png',
      name: 'Organic Raw Pecan',
      price: 110.00,
      qty: '500 gm',
    ),
    Product(
      id: 2,
      imageAsset: 'assets/dummy_product_1.png',
      name: 'Sunflower Cooking Oil',
      price: 140.00,
      qty: '1 kg',
    ),
  ];
}
