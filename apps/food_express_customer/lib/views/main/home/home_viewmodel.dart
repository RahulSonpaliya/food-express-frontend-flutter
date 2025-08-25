import 'package:flutter/cupertino.dart';
import 'package:food_express_customer/views/main/home/category_detail_view/category_detail_view.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/location_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/locator.dart';
import '../../../data/model/bean/category.dart';
import '../../../data/model/bean/market.dart';
import '../../../data/model/bean/user_address.dart';
import '../../../data/remote/repository.dart';
import '../../location/location_view.dart';

class HomeViewModel extends BaseViewModel {
  String longitude = '';
  String latitude = '';
  String address = '';
  List<Category> _categoryList = List.empty(growable: true);
  List<Category> get categoryList => _categoryList;
  List<Market> _marketList = List.empty(growable: true);
  List<Market> get marketList => _marketList;
  final _navigationService = locator.get<NavigationService>();

  HomeViewModel() {
    _getHomeDetails();
  }

  void _getHomeDetails() async {
    setBusyForObject(_marketList, true);
    setBusyForObject(_categoryList, true);
    await _getUserLocation();
    _getAllMarkets();
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
    _navigationService.navigateWithTransition(LocationView(showBack: true),
        transitionStyle: Transition.rightToLeft);
  }

  Future<void> refreshScreen() async {
    setBusyForObject(_marketList, true);
    setBusyForObject(_categoryList, true);
    await _getAllCategory();
    await _getAllMarkets();
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
          _categoryList = categoryResponse.categoryList;
          notifyListeners();
        }
      },
    );
  }

  onCategoryClick(Category category) {
    if (category.id != -1) {
      _navigationService.navigateWithTransition(
        CategoryDetailView(categoryList: categoryList, category: category),
        transitionStyle: Transition.rightToLeft,
      );
    }
  }

  Future _getAllMarkets() async {
    setBusyForObject(_marketList, true);
    var result = await locator<Repository>().getNearbyMarkets(requestBody: {
      "latitude": latitude,
      "longitude": longitude,
    });
    setBusyForObject(_marketList, false);
    result.fold((failure) {
      debugPrint('failure $failure');
      showRetryDialog(failure: failure);
    }, (marketsResponse) async {
      if (marketsResponse.success) {
        _marketList = marketsResponse.marketList;
        notifyListeners();
        debugPrint('response${marketsResponse.marketList.length}');
      }
    });
  }

  nearByStoreListItemClick(Market market) {
    // TODO: implement
  }

  Future<String> calculateDistance(Market market) async {
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
