import 'package:get/get.dart' hide Transition;
import 'package:shared/common_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/locator.dart';
import '../../../../../data/model/bean/cart.dart';
import '../../../../../data/model/bean/category.dart';
import '../../../../../data/model/bean/market.dart';
import '../../../../../data/model/bean/order.dart';
import '../../../../../data/model/bean/product.dart';
import '../../../../../data/model/bean/user.dart';
import '../../../../../data/remote/repository.dart';
import '../../../../login/login_view.dart';

class ProductListViewModel extends BaseViewModel {
  final _navigationService = locator.get<NavigationService>();
  final Category category;
  final Market market;
  ProductListViewModel(this.category, this.market) {
    _getProducts();
  }

  List<Product> _productList = List.empty(growable: true);
  List<Product> get productList => _productList;

  _getProducts() async {
    setBusyForObject(_productList, true);
    var result = await locator
        .get<Repository>()
        .getMarketDetail(market.id, categoryId: category.id);
    setBusyForObject(_productList, false);
    result.fold(
      (failure) => showRetryDialog(failure: failure),
      (r) {
        _productList = r.products;
        notifyListeners();
      },
    );
  }

  Cart? _checkIfProductAlreadyAdded(Product p1) {
    if (appOrderFromServer.value != null) {
      var cart = appOrderFromServer.value?.carts.firstWhereOrNull((e) {
        var option = (p1.options?.isNotEmpty ?? false) ? p1.options![0] : null;
        bool c1 = e.cartItem.product.id == p1.id;
        bool c2 = true;
        if (e.cartItem.option != null && option != null) {
          c2 = e.cartItem.option!.id == option.id;
        }
        return c1 && c2;
      });
      return cart;
    }
    return null;
  }

  plusClick(Product p1) async {
    if (appUser.value == null) {
      _navigationService.navigateWithTransition(LoginView(fromInside: true),
          transitionStyle: Transition.rightToLeft);
      return;
    }
    var cart = _checkIfProductAlreadyAdded(p1);
    if (cart != null) {
      //this product is already existed in cart, now increase its quantity by 1 and call update-cart api
      _callUpdateCartApiNew(cart);
    } else {
      //this product is not already exists in cart
      if (_isSameMarket()) {
        _callAddCartApiNew(p1);
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

  _isSameMarket() {
    if (appOrderFromServer.value == null) {
      //if currently no items is added in cart
      return true;
    }
    if (appOrderFromServer.value?.market == null) {
      //if currently no items is added in cart
      return true;
    }
    if (appOrderFromServer.value?.carts.isEmpty ?? false) {
      //if currently no items is added in cart
      return true;
    }
    //already added item belongs to the same market
    return appOrderFromServer.value?.market.id == market.id;
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

  _callAddCartApiNew(Product p1) async {
    var cartItem = CartItem(
        qty: 1,
        product: p1,
        option: (p1.options?.isNotEmpty ?? false) ? p1.options![0] : null);
    showLoading();
    var result = await locator
        .get<Repository>()
        .addToCart(requestBody: cartItem.toJson());
    await hideLoading();
    result.fold((failure) => showRetryDialog(failure: failure), (res) {
      var cart = Cart(id: res.cartId, cartItem: cartItem);
      var order;
      if (appOrderFromServer.value == null) {
        order = Order(market: market);
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

  minusClick(Product p1) async {
    var cart = _checkIfProductAlreadyAdded(p1);
    if (cart != null) {
      _callUpdateCartApiNew(cart, decreaseQty: true);
    }
  }

  showMinus(Product p1) {
    var cart = _checkIfProductAlreadyAdded(p1);
    return cart != null;
  }

  getQty(Product p1) {
    var cart = _checkIfProductAlreadyAdded(p1);
    if (cart == null) {
      return '';
    } else {
      return '${cart.cartItem.qty}';
    }
  }
}
