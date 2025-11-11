import 'package:shared/common_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/locator.dart';
import '../../../../../data/model/bean/address.dart';
import '../../../../../data/remote/repository.dart';
import '../add_new_address/add_new_address_view.dart';

class MyAddressNewViewModel extends BaseViewModel {
  MyAddressNewViewModel() {
    _getAddressList();
  }

  final _navigationService = locator.get<NavigationService>();
  var _dialogService = locator.get<DialogService>();

  navigateBack() => _navigationService.back();

  bool _checkAddress = false;

  bool get checkAddress => _checkAddress;

  List<AddressBean> _addressList = List.empty(growable: true);

  List<AddressBean> get addressList => _addressList;
  bool _loading = true;

  bool get loading => _loading;

  onCheckOutBack(AddressBean addressList) {
    _navigationService.back(result: addressList);
  }

  addAddressClick() async {
    var isRefresh = await _navigationService.navigateWithTransition(
        AddNewAddressView(),
        transition: NavigationTransition.RightToLeft);
    if (isRefresh != null) {
      _getAddressList();
    }
  }

  updateCheckAddressClick() {
    _checkAddress = false;
    notifyListeners();
  }

  updateSelectedCheckClick() {
    _checkAddress = true;
    notifyListeners();
  }

  void _getAddressList() async {
    _loading = true;
    notifyListeners();
    var result = await locator<Repository>().getAddressList();
    result.fold((failure) => showRetryDialog(failure: failure),
        (addressResponse) async {
      if (addressResponse.success) {
        _loading = false;
        _addressList = addressResponse.addressBeanList;
        notifyListeners();
        print('${addressResponse.addressBeanList.length}');
      }
    });
  }

  void deleteButtonClick(num addressId) async {
    showDialog('Are you sure ?', okBtnTitle: 'Yes', okBtnClick: () {
      deleteAddressApi(addressId);
    }, cancelBtnClick: () {}, cancelBtnTitle: 'No');
  }

  void deleteAddressApi(num addressId) async {
    showLoading();
    var result =
        await locator<Repository>().deleteAddress(addressId: addressId);
    await hideLoading();
    result.fold((failure) => showRetryDialog(failure: failure),
        (addressResponse) async {
      if (addressResponse.success) {
        showDialog(addressResponse.data);
        _getAddressList();
      }
    });
  }

  void setAsDefaultApi(num addressId) async {
    showLoading();
    var result =
        await locator<Repository>().setDefaultAddress(addressId: addressId);
    await hideLoading();
    result.fold((failure) => showRetryDialog(failure: failure),
        (addressResponse) async {
      if (addressResponse.success) {
        showDialog(addressResponse.data);
        _getAddressList();
      }
    });
  }
}
