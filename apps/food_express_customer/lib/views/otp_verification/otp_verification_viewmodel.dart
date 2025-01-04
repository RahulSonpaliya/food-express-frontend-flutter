import 'package:food_express_customer/data/remote/repository.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';

class OtpVerificationViewModel extends BaseViewModel {
  final _navigationService = locator.get<NavigationService>();
  final String countryCode, mobileNum;
  String otp = "";

  OtpVerificationViewModel({
    required this.countryCode,
    required this.mobileNum,
  });

  navigateBack() => _navigationService.back();

  verifyOtp() async {
    if (otp.isEmpty || otp.length < 6) {
      showDialog('Please enter valid otp');
      return;
    }
    showLoading();
    var result = await locator<Repository>().verifyOtp(
      requestBody: _getRequestForVerifyOtp(),
    );
    hideLoading();
    result.fold(
      (failure) => handleFailure(failure),
      (response) {
        showDialog(response.message, okBtnClick: () {
          _navigationService.back(result: true);
        });
      },
    );
  }

  Map<String, String> _getRequestForVerifyOtp() {
    Map<String, String> request = {};
    request['countryCode'] = countryCode;
    request['phoneNumber'] = mobileNum;
    request['otp'] = otp;
    request['accountType'] = acTypeCustomer;
    return request;
  }

  resendOtp() async {
    showLoading();
    var result = await locator<Repository>().resendOtp(
      requestBody: _getRequestForResendOtp(),
    );
    hideLoading();
    result.fold(
      (failure) => handleFailure(failure),
      (response) => showDialog(response.message),
    );
  }

  Map<String, String> _getRequestForResendOtp() {
    Map<String, String> request = {};
    request['countryCode'] = countryCode;
    request['phoneNumber'] = mobileNum;
    request['accountType'] = acTypeCustomer;
    return request;
  }
}
