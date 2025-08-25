import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import '../../../../data/model/bean/category.dart';
import '../../../../data/model/bean/market.dart';

class CategoryDetailViewModel extends BaseViewModel {
  List<Category> categoryList;
  Category category;
  // TODO implement
  // AllMarketsResponse _allMarketsResponse;
  List<Market> marketList = List.empty(growable: true);
  final _navigationService = locator.get<NavigationService>();

  CategoryDetailViewModel(this.category, this.categoryList) {
    _getMarketsByCategory();
  }

  _getMarketsByCategory() async {
    // TODO implement
    // UserAddress userAddress = await UserAddress.getSavedUserAddress();
    // var result = await locator<Repository>().getMarketByCategory(
    //     category.id, userAddress.latitude, userAddress.longitude,
    //     page: currentPage);
    // if (!loadMore) {
    //   setBusyForObject(marketList, false);
    // } else {
    //   _updateLoadMoreFlag(false);
    // }
    // result.fold(
    //   (failure) => handleFailure(failure),
    //   (response) {
    //     _allMarketsResponse = response;
    //     if (!loadMore) {
    //       marketList = response.markets;
    //     } else {
    //       marketList.addAll(response.markets);
    //     }
    //     rebuildUi();
    //   },
    // );
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
