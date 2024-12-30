import 'package:shared/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../login/login_view.dart';

class SignUpViewModel extends BaseViewModel {
  final _navigationService = locator.get<NavigationService>();
  var _dialogService = locator.get<DialogService>();
  var _snackBarService = locator.get<SnackbarService>();

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

  navigateToVerifyOTP() {
    // TODO implement
    // _navigationService.replaceWithTransition(
    //     OtpVerificationView(
    //       countryCode: _selectedCCode,
    //       mobileNum: mobile,
    //     ),
    //     transitionStyle: Transition.rightToLeft);
  }

  signUp() async {
    // TODO implement
  }

  // _handleSignUpResponse(SignUpResponse signUpResponse, String selectedCCode,
  //     String mobile, String password, String confirmPassword) {
  //   if (signUpResponse.isVerify == 0) {
  //     _navigationService.navigateWithTransition(
  //         OtpVerificationView(
  //           countryCode: _selectedCCode,
  //           mobileNum: mobile,
  //         ),
  //         transition: NavigationTransition.RightToLeft);
  //   } else {
  //     _navigationService.navigateWithTransition(
  //         CompleteProfileView(
  //           userId: signUpResponse.isUserId,
  //         ),
  //         transition: NavigationTransition.RightToLeft);
  //   }
  // }

  // Future<Map<String, String>> _getRequestForSignUp() async {
  //   Map<String, String> request = {};
  //   request['country_code'] = _selectedCCode;
  //   request['phone_number'] = mobile;
  //   request['role'] = ROLE;
  //   printMsg("getRequestForSignUp :: $request");
  //   return request;
  // }
}
