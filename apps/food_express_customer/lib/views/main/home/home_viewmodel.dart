import 'package:stacked/stacked.dart';

import '../../../data/model/bean/category.dart';
import '../../../data/model/bean/user_address.dart';

class HomeViewModel extends BaseViewModel {
  String longitude = '';
  String latitude = '';
  String address = '';
  final List<Category> _categoryList = List.empty(growable: true);
  List<Category> get categoryList => _categoryList;

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

  onCategoryClick(Category category) {
    if (category.id != -1) {
      // TODO: implement
    }
  }
}
