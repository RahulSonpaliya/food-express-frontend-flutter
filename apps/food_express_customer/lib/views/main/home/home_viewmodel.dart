import 'package:stacked/stacked.dart';

import '../../../data/model/bean/user_address.dart';

class HomeViewModel extends BaseViewModel {
  String longitude = '';
  String latitude = '';
  String address = '';

  HomeViewModel() {
    _getHomeDetails();
  }

  void _getHomeDetails() async {
    await _getUserLocation();
    notifyListeners();
  }

  _getUserLocation() async {
    UserAddress userAddressBean = await UserAddress.getSavedUserAddress();
    address = userAddressBean.address;
    latitude = userAddressBean.latitude;
    longitude = userAddressBean.longitude;
  }

  editIconTap() {
    // TODO: implement
  }

  Future<void> refreshScreen() async {
    // TODO: implement
  }

  searchClick() {
    // TODO: implement
  }
}
