import 'package:shared/common_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/locator.dart';
import '../../../data/model/api_response/get_cart_response.dart';
import '../../../data/model/bean/cart.dart';
import '../../../data/model/bean/order.dart';
import '../../../data/remote/repository.dart';

class CardViewModel extends BaseViewModel {
  bool _loading = false;
  bool get loading => _loading;

  final _navigationService = locator.get<NavigationService>();
  var _dialogService = locator.get<DialogService>();

  navigateBack() => _navigationService.back();

  CardViewModel() {
    _getCartData();
  }

  _getCartData() async {
    setBusyForObject(_loading, true);
    var result = await locator.get<Repository>().getCart();
    setBusyForObject(_loading, false);
    result.fold((failure) {}, (res) {
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
      appOrderFromServer.notifyListeners();
      _checkIfMarketDeleted(res);
    });
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
    var result = await locator.get<Repository>().clearCart();
    await hideLoading();
    result.fold((failure) => showRetryDialog(failure: failure), (response) {
      appOrderFromServer.value = null;
      appOrderFromServer.notifyListeners();
      showDialog(response.message);
    });
  }

  proceedToCheckOutClick() {
    // TODO implement
    // _navigationService.navigateWithTransition(CheckOutView(),
    //     transition: NavigationTransition.RightToLeft);
  }

  plusClick(Cart? cart) async {
    if (cart != null) {
      //this product is already existed in cart, now increase its quantity by 1 and call update-cart api
      _callUpdateCartApiNew(cart);
    }
  }

  _callUpdateCartApiNew(Cart cart, {bool decreaseQty = false}) async {
    CartItem cartItem2 = CartItem(
        qty: decreaseQty ? cart.cartItem.qty - 1 : cart.cartItem.qty + 1,
        product: cart.cartItem.product,
        option: cart.cartItem.option);
    showLoading();
    var result = await locator
        .get<Repository>()
        .updateCart(cart.id, requestBody: cartItem2.toJson());
    await hideLoading();
    result.fold((failure) => showRetryDialog(failure: failure), (res) {
      decreaseQty ? cart.cartItem.qty-- : cart.cartItem.qty++;
      if (cart.cartItem.qty == 0) {
        appOrderFromServer.value?.carts.remove(cart);
        // appOrderFromServer.notifyListeners();
      }
      _updateCartTotal();
      notifyListeners();
    });
  }

  _updateCartTotal() {
    appOrderFromServer.value?.total = 0;
    appOrderFromServer.value?.carts.forEach((e) {
      var price = e.cartItem.option != null
          ? e.cartItem.option?.price
          : e.cartItem.product.price;
      appOrderFromServer.value?.total += price! * e.cartItem.qty;
    });
    appOrderFromServer.notifyListeners();
  }

  minusClick(Cart? cart) {
    if (cart != null) {
      _callUpdateCartApiNew(cart, decreaseQty: true);
    }
  }
}
