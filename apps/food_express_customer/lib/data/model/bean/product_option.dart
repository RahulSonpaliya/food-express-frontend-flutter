class ProductOption {
  num id = 0;
  String variant_name = '';
  num price = 0;
  ProductOption({
    required this.id,
    required this.variant_name,
    required this.price,
  });

  Map<String, dynamic> toJson(ProductOption obj) {
    return <String, dynamic>{
      'id': obj.id,
      'variant_name': obj.variant_name,
      'price': obj.price,
    };
  }

  factory ProductOption.fromJson(Map<String, dynamic> parsedJson) {
    return ProductOption(
      id: parsedJson['id'],
      variant_name: parsedJson['variant_name'],
      price: parsedJson['price'],
    );
  }
}
