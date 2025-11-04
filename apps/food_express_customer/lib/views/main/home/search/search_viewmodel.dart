import 'package:food_express_customer/views/main/home/user_address_mixin.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared/common_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import '../../../../data/model/bean/category.dart';
import '../../../../data/model/bean/market.dart';
import '../../../../data/model/bean/product.dart';
import '../../../../data/remote/repository.dart';
import '../../product_detail/product_detail_view.dart';
import '../market_detail/market_detail_view.dart';

class SearchViewModel extends BaseViewModel with UserAddressMixin {
  final List<Category> categoryList;

  final _navigationService = locator.get<NavigationService>();
  final searchOnChange = BehaviorSubject<String>();
  List<Product> _searchProductList = List.empty(growable: true);

  List<Product> get searchProductList => _searchProductList;
  List<Market> _userProfileList = List.empty(growable: true);

  List<Market> get userProfileList => _userProfileList;

  navigateBack() => _navigationService.back();

  SearchViewModel({required this.categoryList}) {
    searchOnChange.debounceTime(Duration(milliseconds: 500)).listen((query) {
      _searchProductList = List.empty(growable: true);
      _userProfileList = List.empty(growable: true);
      setBusyForObject(_searchProductList, true);
      setBusyForObject(_userProfileList, true);
      notifyListeners();
      if (query.isNotEmpty) {
        search(query);
      } else {
        setBusyForObject(_searchProductList, false);
        setBusyForObject(_userProfileList, false);
      }
    });
  }

  search(query) async {
    // TODO implement searchProduct api
    // setBusyForObject(_searchProductList, true);
    // setBusyForObject(_userProfileList, true);
    // await getUserAddress();
    // var result = await locator<Repository>().searchProduct(
    //   'fromSearch',
    //   query,
    //   '',
    //   '',
    //   myLat: latitude,
    //   myLong: longitude,
    // );
    // setBusyForObject(_searchProductList, false);
    // setBusyForObject(_userProfileList, false);
    // result.fold((failure) {}, (searchResponse) async {
    //   if (searchResponse.success) {
    //     _searchProductList = searchResponse.searchProductBean;
    //     _userProfileList = searchResponse.userBeanList;
    //     notifyListeners();
    //   }
    // });
  }

  searchProductItemClick(Product p) async {
    // TODO test implementation
    showLoading();
    var result = await locator<Repository>().getMarketDetail(p.market_id ?? 0);
    await hideLoading();
    result.fold((failure) => showRetryDialog(failure: failure), (r) {
      _navigationService.navigateWithTransition(
          ProductDetailView(market: r.market!, product: p),
          transitionStyle: Transition.rightToLeft);
    });
  }

  searchStoreItemClick(Market userProfileList) {
    _navigationService.navigateWithTransition(
        MarketDetailView(
          market: userProfileList,
          categoryList: categoryList,
        ),
        transitionStyle: Transition.rightToLeft);
  }
}
