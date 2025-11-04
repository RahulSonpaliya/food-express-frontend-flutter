import 'dart:convert';

import 'package:food_express_customer/views/login/login_view.dart';
import 'package:get/get.dart' hide Transition;
import 'package:shared/common_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/locator.dart';
import '../../../data/model/bean/cart.dart';
import '../../../data/model/bean/market.dart';
import '../../../data/model/bean/order.dart';
import '../../../data/model/bean/product.dart';
import '../../../data/model/bean/product_option.dart';
import '../../../data/model/bean/user.dart';
import '../../../data/remote/repository.dart';
import '../cart/cart_view.dart';

class ProductDetailViewModel extends BaseViewModel {
  final Product product;
  final Market market;
  ProductDetailViewModel(this.market, this.product) {
    _getProductDetail();
  }

  late Product _productDetail;
  Product get productDetail => _productDetail;

  ProductOption? _selectedOption;
  ProductOption? get selectedOption => _selectedOption;

  updateSelectedOption(ProductOption option) {
    _selectedOption = option;
    notifyListeners();
  }

  _getProductDetail() async {
    setBusy(true);
    var result = await locator<Repository>().getProductDetail(product.id);
    setBusy(false);
    result.fold((failure) => showRetryDialog(failure: failure), (pDetailRes) {
      _productDetail = pDetailRes.product;
      if (_productDetail.options?.isNotEmpty ?? false) {
        _selectedOption = _productDetail.options![0];
      }
      notifyListeners();
    });
  }

  final _navigationService = locator.get<NavigationService>();
  var _dialogService = locator.get<DialogService>();
  final _snackBarService = locator.get<SnackbarService>();

  navigateBack() => _navigationService.back();

  navigateToOrderDetail() {
    // TODO implement OrderDetailView
    // _navigationService.navigateWithTransition(OrderDetailView(),
    //     transitionStyle: Transition.rightToLeft);
  }

  navigateToAddToCart() {
    _navigationService.navigateWithTransition(CartView(),
        transitionStyle: Transition.rightToLeft);
  }

  late Order order;

  plusClick() async {
    if (appUser.value == null) {
      _navigationService.navigateWithTransition(LoginView(fromInside: true),
          transitionStyle: Transition.rightToLeft);
      return;
    }
    var cart = _checkIfProductAlreadyAdded(_productDetail);
    if (cart != null) {
      //this product is already existed in cart, now increase its quantity by 1 and call update-cart api
      _callUpdateCartApiNew(cart);
    } else {
      //this product is not already exists in cart
      if (_isSameMarket()) {
        _callAddCartApiNew();
      } else {
        showDialog(
          'You must add products of same markets, choose one market only!',
          dialogTitle: 'Reset Cart?',
          okBtnTitle: 'Reset',
          cancelBtnTitle: 'Cancel',
          okBtnClick: _resetCartApi,
        );
      }
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
      }
      _updateCartTotal();
      notifyListeners();
    });
  }

  _callAddCartApiNew() async {
    var cartItem =
        CartItem(qty: 1, product: _productDetail, option: _selectedOption);
    showLoading();
    var result = await locator<Repository>()
        .addToCart(requestBody: _getRequestForAddCart(cartItem));
    await hideLoading();
    result.fold((failure) => showRetryDialog(failure: failure), (res) {
      var cart = Cart(id: res.cartId, cartItem: cartItem);
      var order;
      if (appOrderFromServer.value == null) {
        order = Order(market: market);
        order.market = market;
        order.carts.add(cart);
        appOrderFromServer.value = order;
      } else {
        order = appOrderFromServer.value;
        order.market = market;
        order.carts.add(cart);
      }
      _updateCartTotal();
      notifyListeners();
    });
  }

  _isSameMarket() {
    if (appOrderFromServer.value == null) {
      //if currently no items is added in cart
      return true;
    }
    if (appOrderFromServer.value!.carts.isEmpty) {
      //if currently no items is added in cart
      return true;
    }
    //already added item belongs to the same market
    return appOrderFromServer.value!.market.id == market.id;
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

  minusClick() async {
    var cart = _checkIfProductAlreadyAdded(_productDetail);
    if (cart != null) {
      _callUpdateCartApiNew(cart, decreaseQty: true);
    }
  }

  Cart? _checkIfProductAlreadyAdded(Product p1) {
    if (appOrderFromServer.value != null) {
      var cart = appOrderFromServer.value!.carts.firstWhereOrNull((e) {
        bool c1 = e.cartItem.product.id == p1.id;
        bool c2 = true;
        if (e.cartItem.option != null && _selectedOption != null) {
          c2 = e.cartItem.option!.id == _selectedOption!.id;
        }
        return c1 && c2;
      });
      return cart;
    }
    return null;
  }

  showMinus() {
    var cart = _checkIfProductAlreadyAdded(productDetail);
    return cart != null;
  }

  getQty() {
    var cart = _checkIfProductAlreadyAdded(productDetail);
    if (cart == null) {
      return '';
    } else {
      return '${cart.cartItem.qty}';
    }
  }

  showViewCartBtn() {
    _navigationService.navigateWithTransition(CartView(),
        transitionStyle: Transition.rightToLeft);
  }

  _updateCartTotal() {
    if (appOrderFromServer.value != null) {
      appOrderFromServer.value!.total = 0;
      for (var e in appOrderFromServer.value!.carts) {
        var price = e.cartItem.option != null
            ? e.cartItem.option!.price
            : e.cartItem.product.price;
        appOrderFromServer.value!.total += price * e.cartItem.qty;
      }
      appOrderFromServer.notifyListeners();
    }
  }

  _getRequestForAddCart(CartItem cartItem) {
    List<Map> items = List.empty(growable: true);
    items.add(cartItem.toJson());
    var body = json.encode({"cart_data": items});
    return body;
  }
}
