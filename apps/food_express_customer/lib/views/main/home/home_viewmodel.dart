import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../data/model/bean/category.dart';
import '../../../data/model/bean/user_address.dart';
import '../../../data/remote/repository.dart';

class HomeViewModel extends BaseViewModel {
  String longitude = '';
  String latitude = '';
  String address = '';
  List<Category> _categoryList = List.empty(growable: true);
  List<Category> get categoryList => _categoryList;

  HomeViewModel() {
    _getHomeDetails();
  }

  void _getHomeDetails() async {
    await _getUserLocation();
    _getAllCategory();
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
    setBusyForObject(_categoryList, true);
    await _getAllCategory();
  }

  searchClick() {
    // TODO: implement
  }

  Future _getAllCategory() async {
    setBusyForObject(_categoryList, true);
    var result = await locator<Repository>().getAllCategories();
    setBusyForObject(_categoryList, false);
    result.fold(
      (failure) {},
      (categoryResponse) async {
        if (categoryResponse.success) {
          categoryResponse.categoryList.insert(0, Category.ALL);
          _categoryList = categoryResponse.categoryList;
          notifyListeners();
        }
      },
    );
  }

  onCategoryClick(Category category) {
    if (category.id != -1) {
      // TODO: implement
    }
  }
}
