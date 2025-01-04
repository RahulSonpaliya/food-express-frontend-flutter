import 'package:food_express_customer/data/remote/repository.dart';
import 'package:shared/app/locator.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/data/local/app_shared_prefs.dart';
import 'package:shared/data/local/preference_keys.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../data/model/bean/user.dart';
import '../forgot_password/forgot_password_view.dart';
import '../otp_verification/otp_verification_view.dart';
import '../signup/sign_up_view.dart';

class LogInViewModel extends BaseViewModel {
  final _navigationService = locator.get<NavigationService>();
  String mobile = '';
  String password = '';

  String _selectedCCode = '+1';
  String get selectedCCode => _selectedCCode;

  updateCountryCode(String val) {
    _selectedCCode = val;
    notifyListeners();
  }

  navigateToForgotPassword() {
    _navigationService.navigateWithTransition(ForgotPasswordView(),
        transitionStyle: Transition.rightToLeft);
  }

  navigateToSignUp() {
    _navigationService.replaceWithTransition(SignUpView(),
        transitionStyle: Transition.rightToLeft);
  }

  navigateToVerifyOTP() {
    _navigationService.navigateWithTransition(
      OtpVerificationView(countryCode: _selectedCCode, mobileNum: mobile),
      transitionStyle: Transition.rightToLeft,
    );
  }

  login() async {
    showLoading();
    var result = await locator<Repository>().logIn(
      requestBody: _getRequestForLogIn(),
    );
    hideLoading();
    result.fold(
      (failure) => handleFailure(failure),
      (response) async {
        if (response.otpVerified) {
          await User.saveUser(response.user!);
        }
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

  Map<String, String> _getRequestForLogIn() {
    Map<String, String> request = {};
    request['countryCode'] = selectedCCode;
    request['phoneNumber'] = mobile;
    request['password'] = password;
    request['accountType'] = 'CUSTOMER';
    return request;
  }

  guestLogin() async {
    await AppSharedPrefs.get().addBoolean(PreferenceKeys.GUEST_USER, true);
    // _navigationService.replaceWithTransition(LocationView(),
    //     transition: NavigationTransition.RightToLeft);
  }

  navigateBack() {
    _navigationService.back();
  }
}
