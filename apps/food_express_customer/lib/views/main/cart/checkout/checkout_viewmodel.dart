import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import '../../../../data/model/bean/card.dart';
import '../../../../data/model/bean/order.dart';

class CheckOutViewModel extends BaseViewModel {
  CheckOutViewModel() {
    _getDeliveryAddress();
  }

  num tip = 0;
  TextEditingController tipCtrl = TextEditingController();
  var tipAmounts = [5, 10, 15, 0];

  updateTip(t, {bool updateTextField = true}) {
    tip = t;
    notifyListeners();
    if (updateTextField) {
      if (t == 0) {
        tipCtrl.text = '';
      } else {
        tipCtrl.text = '$t';
      }
    }
  }

  final _navigationService = locator.get<NavigationService>();
  final _dialogService = locator.get<DialogService>();

  navigateBack() => _navigationService.back();

  Card? card;

  orderNowClick() async {
    // TODO implement
    // if (card == null) {
    //   showDialog('Please add payment method');
    //   return;
    // }
    // showLoading();
    // var result = await locator<Repository>()
    //     .postOrder(requestBody: _getRequestForPostOrder());
    // await hideLoading();
    // result.fold((failure) => showRetryDialog(failure: failure), (res) {
    //   Get.Get.offAll(OrderView(res.orderId), transition: Get.Transition.rightToLeft);
    //   appOrderFromServer.value = null;
    //   appOrderFromServer.notifyListeners();
    // });
  }

  Map<String, String> _getRequestForPostOrder() {
    Map<String, String> req = Map();
    req['vendor_id'] = "${appOrderFromServer.value?.market.id}";
    // TODO implement
    // req['delivery_address_id'] = '${selectedAddress.addressId}';
    req['card_token'] = '${card?.card_id}';
    req['delivery_fee'] = "${appOrderFromServer.value?.deliveryFee}";
    req['sub_total'] = "${appOrderFromServer.value?.total}";
    req['tip_amount'] = "$tip";
    req['total_amount'] =
        "${(appOrderFromServer.value?.total ?? 0) + (appOrderFromServer.value?.deliveryFee ?? 0) + tip}";
    return req;
  }

  // TODO implement
  // AddressBean selectedAddress;

  _getDeliveryAddress() async {
    // TODO implement
    // appOrderFromServer.value?.deliveryFee = 0;
    // _updateCartTotal();
    // setBusyForObject(selectedAddress, true);
    // var result = await locator<Repository>().getAddressList();
    // setBusyForObject(selectedAddress, false);
    // result.fold((failure) => showRetryDialog(failure: failure),
    //     (addressResponse) {
    //   selectedAddress = addressResponse.addressBeanList
    //       .firstWhere((element) => element.isDefault, orElse: () => null);
    //   notifyListeners();
    //   if (selectedAddress != null) _getDeliverCharges();
    // });
  }

  _getDeliverCharges() async {
    // TODO implement
    // showLoading();
    // var result = await locator<Repository>().getDeliveryCharges(
    //     selectedAddress.addressId, appOrderFromServer.value?.market.id);
    // await hideLoading();
    // result.fold((failure) => showRetryDialog(failure: failure), (res) {
    //   appOrderFromServer.value?.deliveryFee = res.deliveryCharge;
    //   _updateCartTotal();
    //   notifyListeners();
    // });
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

  navigateToMyAddress() async {
    // TODO implement
    // var add = await _navigationService.navigateWithTransition(
    //     MyAddressNewView(
    //       fromCheckOutScreen: true,
    //     ),
    //     transitionStyle: Transition.rightToLeft);
    // if (add != null) {
    //   selectedAddress = add;
    //   notifyListeners();
    //   _getDeliverCharges();
    // }
  }

  addCardClick() async {
    // TODO implement
    // card = await _navigationService.navigateWithTransition(PaymentMethodView(),
    //     transitionStyle: Transition.rightToLeft);
    // notifyListeners();
  }
}
