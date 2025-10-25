import 'package:food_express_customer/views/reset_password/reset_password_view.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../data/remote/repository.dart';
import '../otp_verification/otp_verification_view.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  final _navigationService = locator.get<NavigationService>();
  String mobile = '';
  String _selectedCCode = '+1';
  String get selectedCCode => _selectedCCode;

  updateCountryCode(String val) {
    _selectedCCode = val;
    notifyListeners();
  }

  navigateToVerifyOTP() async {
    bool? result = await _navigationService.navigateWithTransition(
      OtpVerificationView(countryCode: _selectedCCode, mobileNum: mobile),
      transitionStyle: Transition.rightToLeft,
    );
    if (result ?? false) {
      _navigationService.navigateWithTransition(
        ResetPasswordView(countryCode: _selectedCCode, phoneNumber: mobile),
        transitionStyle: Transition.rightToLeft,
      );
    }
  }

  submit() async {
    showLoading();
    var result = await locator<Repository>().resendOtp(
      requestBody: _getRequestForSendOtp(),
    );
    hideLoading();
    result.fold(
      (failure) => handleFailure(failure),
      (response) => showDialog(
        response.message,
        okBtnClick: navigateToVerifyOTP,
      ),
    );
  }

  Map<String, String> _getRequestForSendOtp() {
    Map<String, String> request = {};
    request['country_code'] = _selectedCCode;
    request['phone_number'] = mobile;
    request['account_type'] = acTypeCustomer;
    return request;
  }
}
