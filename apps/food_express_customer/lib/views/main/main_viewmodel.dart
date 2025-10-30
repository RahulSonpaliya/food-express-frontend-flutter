import 'package:food_express_customer/data/remote/repository.dart';
import 'package:food_express_customer/views/login/login_view.dart';
import 'package:shared/common_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../data/model/api_response/get_cart_response.dart';
import '../../data/model/bean/cart.dart';
import '../../data/model/bean/order.dart';
import '../../data/model/bean/user.dart';

class MainViewModel extends BaseViewModel {
  final _navigationService = locator.get<NavigationService>();
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  MainViewModel() {
    locator<Repository>().updateHeader().then((v) {
      if (appUser.value != null) {
        _getCartData();
      }
    });
    // TODO: implement
    // _handleNotifications();
  }

  updateTabIndex(i) {
    _tabIndex = i;
    notifyListeners();
  }

  navigateToLogin() {
    _navigationService.navigateWithTransition(LoginView(fromInside: true),
        transitionStyle: Transition.rightToLeft);
  }

  _getCartData() async {
    var result = await locator<Repository>().getCart();
    result.fold(
      (failure) => {},
      (res) {
        if (res.products.isNotEmpty && res.vendorDetail != null) {
          final order = Order(market: res.vendorDetail!);
          order.deliveryFee = res.deliveryPrice;
          order.carts = res.products.map((p) {
            final cartItem = CartItem(qty: num.parse(p.qty!), product: p);
            final cart = Cart(id: res.cartId, cartItem: cartItem);
            return cart;
          }).toList(growable: true);
          appOrderFromServer.value = order;
        }
        _updateCartTotal();
        _checkIfMarketDeleted(res);
      },
    );
  }

  _checkIfMarketDeleted(GetCartResponse res) async {
    if (res.products.isNotEmpty && res.vendorDetail == null) {
      var _dialogRes = await showDialog(
          'Vendor is not available, please reset your cart.',
          okBtnTitle: 'Reset Cart', okBtnClick: () {
        _resetCartApi();
      });
      if (_dialogRes == null) {
        //on android device if user presses back button
        _checkIfMarketDeleted(res);
      }
    }
  }

  _resetCartApi() async {
    showLoading();
    var result = await locator<Repository>().clearCart();
    await hideLoading();
    result.fold((failure) => showRetryDialog(failure: failure), (response) {
      appOrderFromServer.value = null;
      appOrderFromServer.notifyListeners();
      showDialog(response.message);
    });
  }

  _updateCartTotal() {
    appOrderFromServer.value?.total = 0;
    appOrderFromServer.value?.carts.forEach((e) {
      var price = e.cartItem.option != null
          ? e.cartItem.option!.price
          : e.cartItem.product.price;
      appOrderFromServer.value?.total += price * e.cartItem.qty;
    });
    appOrderFromServer.notifyListeners();
  }
}
