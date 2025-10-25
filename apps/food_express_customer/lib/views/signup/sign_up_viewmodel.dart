import 'package:food_express_customer/data/remote/repository.dart';
import 'package:shared/app/locator.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../login/login_view.dart';
import '../otp_verification/otp_verification_view.dart';

class SignUpViewModel extends BaseViewModel {
  final _navigationService = locator.get<NavigationService>();

  String name = "", email = "";
  String password = "";
  String confirmPassword = "";
  String mobile = '';

  bool _agree = false;

  bool get agree => _agree;

  String _selectedCCode = '+1';

  String get selectedCCode => _selectedCCode;

  updateAgreeToTerms(bool? val) {
    _agree = val!;
    notifyListeners();
  }

  updateCountryCode(String val) {
    _selectedCCode = val;
    notifyListeners();
  }

  navigateToTerms() {}

  navigateToPrivacy() {}

  navigateToLogin() {
    _navigationService.replaceWithTransition(LoginView(),
        transitionStyle: Transition.rightToLeft);
  }

  navigateToVerifyOTP() async {
    bool? result = await _navigationService.navigateWithTransition(
      OtpVerificationView(countryCode: _selectedCCode, mobileNum: mobile),
      transitionStyle: Transition.rightToLeft,
    );
    if (result ?? false) {
      navigateToLogin();
    }
  }

  signUp() async {
    if (!agree) {
      showDialog("Please accept terms conditions & privacy policy.");
      return;
    }
    showLoading();
    var result = await locator<Repository>().signUp(
      requestBody: _getRequestForSignUp(),
    );
    hideLoading();
    result.fold(
      (failure) => handleFailure(failure),
      (response) {
        showDialog(response.message, okBtnClick: () {
          if (response.otpVerified) {
            // TODO implement -> redirect to location page
          } else {
            navigateToVerifyOTP();
          }
        });
      },
    );
  }

  Map<String, String> _getRequestForSignUp() {
    Map<String, String> request = {};
    request['country_code'] = _selectedCCode;
    request['phone_number'] = mobile;
    request['name'] = name;
    request['email_id'] = email;
    request['password'] = password;
    request['confirm_password'] = confirmPassword;
    request['account_type'] = acTypeCustomer;
    return request;
  }
}
