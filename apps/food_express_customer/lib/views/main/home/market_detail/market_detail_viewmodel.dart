import 'package:food_express_customer/views/main/home/user_address_mixin.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import '../../../../data/model/bean/market.dart';
import '../../../../data/model/bean/product.dart';
import '../../cart/cart_view.dart';
import '../../product_detail/product_detail_view.dart';

class MarketDetailViewModel extends BaseViewModel with UserAddressMixin {
  final Market market;
  final _navigationService = locator.get<NavigationService>();
  final _snackBarService = locator.get<SnackbarService>();

  MarketDetailViewModel(this.market);

  navigateBack() => _navigationService.back();

  showViewCartBtn() {
    _navigationService.navigateWithTransition(CartView(),
        transitionStyle: Transition.rightToLeft);
  }

  navigateToProductDetail(Market market, Product product) {
    _navigationService.navigateWithTransition(
        ProductDetailView(market: market, product: product),
        transitionStyle: Transition.rightToLeft);
  }
}
