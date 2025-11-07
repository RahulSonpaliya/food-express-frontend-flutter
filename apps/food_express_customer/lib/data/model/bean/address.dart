class AddressBean {
  num addressId, userId, latitude, longitude;
  String address, address2, city, country, addressNickName, description;
  bool isDefault;
  String status;
  String createdAt;
  String updatedAt;

  AddressBean({
    this.addressId = 0,
    this.userId = 0,
    this.latitude = 0,
    this.longitude = 0,
    this.address = "",
    this.address2 = "",
    this.city = "",
    this.country = "",
    this.addressNickName = "",
    this.description = "",
    this.isDefault = false,
    this.status = "",
    this.createdAt = "",
    this.updatedAt = "",
  });

  factory AddressBean.fromJson(Map<String, dynamic> parsedJson) {
    return AddressBean(
      addressId: parsedJson['id'] ?? 0,
      userId: parsedJson['user_id'] ?? 0,
      address: parsedJson['address'] ?? "",
      address2: parsedJson['address_2'] ?? "",
      city: parsedJson['city'] ?? "",
      country: parsedJson['country'] ?? "",
      latitude: parsedJson['latitude'] ?? 0,
      longitude: parsedJson['longitude'] ?? 0,
      addressNickName: parsedJson['address_nick_name'] ?? "",
      description: parsedJson['description'] ?? "",
      isDefault: parsedJson['is_default'] ?? false,
      status: parsedJson['status'] ?? "",
      createdAt: parsedJson['created_at'] ?? "",
      updatedAt: parsedJson['updated_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson(AddressBean obj) {
    return <String, dynamic>{
      'id': obj.addressId,
      'user_id': obj.userId,
      'address': obj.address,
      'address_2': obj.address2,
      'city': obj.city,
      'country': obj.country,
      'latitude': obj.latitude,
      'longitude': obj.longitude,
      'address_nick_name': obj.addressNickName,
      'description': obj.description,
      'is_default': obj.isDefault,
      'status': obj.status,
      'created_at': obj.createdAt,
      'updated_at': obj.updatedAt,
    };
  }
}
