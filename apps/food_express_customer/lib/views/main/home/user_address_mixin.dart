import 'package:shared/location_utils.dart';

import '../../../data/model/bean/market.dart';
import '../../../data/model/bean/user_address.dart';

mixin UserAddressMixin {
  String longitude = '';
  String latitude = '';
  String address = '';

  getUserAddress() async {
    UserAddress userAddressBean = await UserAddress.getSavedUserAddress();
    address = userAddressBean.address;
    latitude = userAddressBean.latitude;
    longitude = userAddressBean.longitude;
  }

  Future<String> calculateDistance(Market market) async {
    if (longitude.isEmpty && latitude.isEmpty && address.isEmpty) {
      await getUserAddress();
    }
    final distanceInMeters = LocationUtils.getDistanceBetween2LatLng(
        double.parse(latitude),
        double.parse(longitude),
        market.latitude.toDouble(),
        market.longitude.toDouble());
    double roundDistanceInMeters =
        double.parse((distanceInMeters).toStringAsFixed(0));
    return '$roundDistanceInMeters Meters';
  }
}
