import 'package:flutter/material.dart';
import 'package:shared/common_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import '../../../../data/model/bean/category.dart';
import '../../../../data/model/bean/market.dart';
import '../../../../data/model/bean/user_address.dart';
import '../../../../data/remote/repository.dart';

class CategoryDetailViewModel extends BaseViewModel {
  List<Category> categoryList;
  Category category;
  List<Market> _marketList = List.empty(growable: true);
  List<Market> get marketList => _marketList;
  final _navigationService = locator.get<NavigationService>();

  CategoryDetailViewModel(this.category, this.categoryList) {
    _getMarketsByCategory();
  }

  _getMarketsByCategory() async {
    UserAddress userAddress = await UserAddress.getSavedUserAddress();
    setBusyForObject(_marketList, true);
    var result = await locator<Repository>().getNearbyMarkets(requestBody: {
      "latitude": userAddress.latitude,
      "longitude": userAddress.longitude,
      "categoryId": category.id.toString(),
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

  loadMoreMarkets() {
    // TODO implement in next version
    // if (_allMarketsResponse != null &&
    //     _allMarketsResponse.lastPage > currentPage) {
    //   currentPage++;
    //   _getMarketsByCategory(loadMore: true);
    // }
  }

  navigateBack() => _navigationService.back();

  nearByStoreListItemClick(Market market) {
    // TODO implement
    // _navigationService.navigateWithTransition(
    //   MarketDetailView(
    //     market: market,
    //     categoryList: categoryList,
    //   ),
    //   transitionStyle: Transition.rightToLeft,
    // );
  }
}
