import 'product.dart';
import 'product_option.dart';

class Cart {
  final num id;
  final CartItem cartItem;
  final List<CartItem> items = List.empty(growable: true);

  Cart({required this.id, required this.cartItem});
}

class CartItem {
  num qty;
  Product product;
  ProductOption? option;
  CartItem({
    required this.qty,
    required this.product,
    this.option,
  });

  Map<String, dynamic> toJson({bool qtyOnly = false}) {
    var map = <String, dynamic>{};
    if (qtyOnly) {
      map['quantity'] = qty;
      return map;
    }
    map["product_id"] = product.id;
    if (option != null) {
      map['variant_id'] = '${option!.id}';
    }
    map['quantity'] = '$qty';
    return map;
  }
}
