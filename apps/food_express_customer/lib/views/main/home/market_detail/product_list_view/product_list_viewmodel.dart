import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/locator.dart';
import '../../../../../data/model/bean/category.dart';
import '../../../../../data/model/bean/market.dart';
import '../../../../../data/model/bean/product.dart';

class ProductListViewModel extends BaseViewModel {
  var _dialogService = locator.get<DialogService>();
  final Category category;
  final Market market;
  ProductListViewModel(this.category, this.market) {
    _getProducts();
  }

  final List<Product> _productList = List.empty(growable: true);
  List<Product> get productList => _productList;

  _getProducts() async {
    // TODO implement getMarketDetail api
    // setBusyForObject(_productList, true);
    // var result = await locator
    //     .get<Repository>()
    //     .getMarketDetail(market.id, categoryId: category.id);
    // setBusyForObject(_productList, false);
    // result.fold((failure) => showRetryDialog(failure: failure), (r) {
    //   _productList = r.products;
    //   notifyListeners();
    // });
  }

  // TODO implement all
  // Cart _checkIfProductAlreadyAdded(Product p1) {
  //   if (appOrderFromServer.value != null) {
  //     var cart = appOrderFromServer.value.carts.firstWhere((e) {
  //       var option = p1.options.isNotEmpty ? p1.options[0] : null;
  //       bool c1 = e.cartItem.product.id == p1.id;
  //       bool c2 = true;
  //       if (e.cartItem.option != null && option != null) {
  //         c2 = e.cartItem.option.id == option.id;
  //       }
  //       return c1 && c2;
  //     }, orElse: () => null);
  //     return cart;
  //   }
  //   return null;
  // }
  //
  // plusClick(Product p1) async {
  //   if (appUser.value == null) {
  //     navService().navigateWithTransition(
  //         LogInViewNew(
  //           fromInside: true,
  //         ),
  //         transition: NavigationTransition.RightToLeft);
  //     return;
  //   }
  //   var cart = _checkIfProductAlreadyAdded(p1);
  //   if (cart != null) {
  //     //this product is already existed in cart, now increase its quantity by 1 and call update-cart api
  //     _callUpdateCartApiNew(cart);
  //   } else {
  //     //this product is not already exists in cart
  //     if (_isSameMarket()) {
  //       _callAddCartApiNew(p1);
  //     } else {
  //       showDialog2(
  //         'You must add products of same markets, choose one market only!',
  //         dialogTitle: 'Reset Cart?',
  //         okBtnTitle: 'Reset',
  //         cancelBtnTitle: 'Cancel',
  //         okBtnClick: _resetCartApi,
  //       );
  //     }
  //   }
  // }
  //
  // _isSameMarket() {
  //   if (appOrderFromServer.value == null) {
  //     //if currently no items is added in cart
  //     return true;
  //   }
  //   if (appOrderFromServer.value.market == null) {
  //     //if currently no items is added in cart
  //     return true;
  //   }
  //   if (appOrderFromServer.value.carts.isEmpty) {
  //     //if currently no items is added in cart
  //     return true;
  //   }
  //   //already added item belongs to the same market
  //   return appOrderFromServer.value.market.id == market.id;
  // }
  //
  // _resetCartApi() async {
  //   showLoading();
  //   var result = await Repository.get().clearCart();
  //   await hideLoading();
  //   result.fold((failure) => showRetryDialog(failure: failure), (response) {
  //     appOrderFromServer.value = null;
  //     appOrderFromServer.notifyListeners();
  //     showDialog2(response.message);
  //   });
  // }
  //
  // _callUpdateCartApiNew(Cart cart, {bool decreaseQty = false}) async {
  //   CartItem cartItem2 = CartItem(
  //       qty: decreaseQty ? cart.cartItem.qty - 1 : cart.cartItem.qty + 1,
  //       product: cart.cartItem.product,
  //       option: cart.cartItem.option);
  //   showLoading();
  //   var result = await Repository.get().updateCart(cart.id,
  //       requestBody: json.encode(cartItem2.toJson(qtyOnly: true)));
  //   await hideLoading();
  //   result.fold((failure) => showRetryDialog(failure: failure), (res) {
  //     decreaseQty ? cart.cartItem.qty-- : cart.cartItem.qty++;
  //     _updateCartTotal();
  //     notifyListeners();
  //   });
  // }
  //
  // _callAddCartApiNew(Product p1) async {
  //   var cartItem = CartItem(
  //       qty: 1,
  //       product: p1,
  //       option: p1.options.isNotEmpty ? p1.options[0] : null);
  //   showLoading();
  //   var result = await Repository.get()
  //       .addToCart(requestBody: _getRequestForAddCart(cartItem));
  //   await hideLoading();
  //   result.fold((failure) => showRetryDialog(failure: failure), (res) {
  //     var cart = Cart();
  //     cart.id = res.id;
  //     cart.cartItem = cartItem;
  //     var order;
  //     if (appOrderFromServer.value == null) {
  //       order = Order();
  //       order.market = market;
  //       order.carts = List<Cart>();
  //       order.carts.add(cart);
  //       appOrderFromServer.value = order;
  //     } else {
  //       order = appOrderFromServer.value;
  //       order.market = market;
  //       order.carts.add(cart);
  //     }
  //     _updateCartTotal();
  //     notifyListeners();
  //   });
  // }
  //
  // _updateCartTotal() {
  //   appOrderFromServer.value.total = 0;
  //   appOrderFromServer.value.carts.forEach((e) {
  //     var price = e.cartItem.option != null
  //         ? e.cartItem.option.price
  //         : e.cartItem.product.price;
  //     appOrderFromServer.value.total += price * e.cartItem.qty;
  //   });
  //   appOrderFromServer.notifyListeners();
  // }
  //
  // _getRequestForAddCart(CartItem cartItem) {
  //   List<Map> items = List();
  //   items.add(cartItem.toJson());
  //   var body = json.encode({"cart_data": items});
  //   return body;
  // }
  //
  // minusClick(Product p1) async {
  //   var cart = _checkIfProductAlreadyAdded(p1);
  //   if (cart != null) {
  //     //this product is already existed in cart, now increase its quantity by 1 and call update-cart api
  //     if (cart.cartItem.qty > 1) {
  //       _callUpdateCartApiNew(cart, decreaseQty: true);
  //     } else {
  //       //if quantity is 1 than delete this cart
  //       _callDeleteCartApi(cart);
  //     }
  //   }
  // }
  //
  // _callDeleteCartApi(Cart cart) async {
  //   showLoading();
  //   var result = await Repository.get().deleteCart(cart.id);
  //   await hideLoading();
  //   result.fold((failure) => showRetryDialog(failure: failure), (res) {
  //     appOrderFromServer.value.carts.remove(cart);
  //     _updateCartTotal();
  //     notifyListeners();
  //   });
  // }
  //
  // showMinus(Product p1) {
  //   var cart = _checkIfProductAlreadyAdded(p1);
  //   return cart != null;
  // }
  //
  // getQty(Product p1) {
  //   var cart = _checkIfProductAlreadyAdded(p1);
  //   if (cart == null) {
  //     return '';
  //   } else {
  //     return '${cart.cartItem.qty}';
  //   }
  // }
}
