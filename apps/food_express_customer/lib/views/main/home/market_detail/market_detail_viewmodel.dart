import 'package:food_express_customer/views/main/home/user_address_mixin.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import '../../../../data/model/bean/market.dart';
import '../../../../data/model/bean/product.dart';

class MarketDetailViewModel extends BaseViewModel with UserAddressMixin {
  final Market market;
  final _navigationService = locator.get<NavigationService>();
  final _snackBarService = locator.get<SnackbarService>();

  MarketDetailViewModel(this.market);

  navigateBack() => _navigationService.back();

  showViewCartBtn() {
    // TODO implement
    // _navigationService.navigateWithTransition(CartView(), transition: NavigationTransition.RightToLeft);
  }

  navigateToProductDetail(Market market, Product product) {
    // TODO implement
    // _navigationService.navigateWithTransition(ProductDetailView(market, product), transition: NavigationTransition.RightToLeft);
  }
}
