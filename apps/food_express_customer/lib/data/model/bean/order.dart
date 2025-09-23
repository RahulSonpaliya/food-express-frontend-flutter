import 'package:flutter/material.dart';

import 'cart.dart';
import 'market.dart';
import 'user_address.dart';

ValueNotifier<Order?> appOrderFromServer = ValueNotifier<Order?>(null);

class Order {
  Market market;
  num total = 0,
      subTotal = 0,
      deliveryFee = 0,
      order_id = 0,
      tip = 0,
      id = 0,
      driver_id = 0,
      vendor_id = 0;
  String? order_status_id;
  List<Cart> carts = List<Cart>.empty(growable: true);
  List<OrderStatus>? orderStatusList;
  Driver? driver;
  UserAddress? address;

  Order({required this.market});
}

class Driver {
  final String? name, image, phone_number, country_code;
  final num? rating;

  Driver(
      {this.name,
      this.image,
      this.rating,
      this.phone_number,
      this.country_code});

  factory Driver.fromJson(Map<String, dynamic> parsedJson) {
    return Driver(
      name: parsedJson['name'],
      image: parsedJson['image'],
      rating: parsedJson['rating'],
      phone_number: parsedJson['phone_number'],
      country_code: parsedJson['country_code'],
    );
  }
}

class OrderStatus {
  final String? status_name, date;
  final bool? is_default;

  OrderStatus({this.status_name, this.date, this.is_default});

  factory OrderStatus.fromJson(Map<String, dynamic> parsedJson) {
    return OrderStatus(
      status_name: parsedJson['status_name'],
      date: parsedJson['date'],
      is_default: parsedJson['is_default'],
    );
  }
}
