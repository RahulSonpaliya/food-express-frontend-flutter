class Market {
  final num id;
  final String name;
  final String image;
  final String address;
  final String status;
  final String openTime;
  final String closeTime;
  final num? rating;
  final num latitude;
  final num longitude;

  Market({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    required this.status,
    required this.openTime,
    required this.closeTime,
    required this.rating,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson(Market obj) {
    return <String, dynamic>{
      'id': obj.id,
      'name': obj.name,
      'image': obj.image,
      'address': obj.address,
      'status': obj.status,
      'openTime': obj.openTime,
      'closeTime': obj.closeTime,
      'rating': obj.rating,
      'latitude': obj.latitude,
      'longitude': obj.longitude,
    };
  }

  factory Market.fromJson(Map<String, dynamic> parsedJson) {
    return Market(
      id: parsedJson['id'],
      name: parsedJson['name'],
      image: parsedJson['image'],
      address: parsedJson['address'],
      status: parsedJson['status'],
      openTime: parsedJson['open_time'],
      closeTime: parsedJson['close_time'],
      rating: parsedJson['rating'],
      latitude: parsedJson['latitude'],
      longitude: parsedJson['longitude'],
    );
  }
}
