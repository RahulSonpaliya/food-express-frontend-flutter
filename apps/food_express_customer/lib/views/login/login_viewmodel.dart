import 'package:food_express_customer/data/remote/repository.dart';
import 'package:shared/app/locator.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/data/local/app_shared_prefs.dart';
import 'package:shared/data/local/preference_keys.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
    // TODO implement
    // _navigationService.navigateWithTransition(ForgotPasswordView(),
    //     transition: NavigationTransition.RightToLeft);
  }

  navigateToSignUp() {
    _navigationService.replaceWithTransition(SignUpView(),
        transitionStyle: Transition.rightToLeft);
  }

  login() async {
    showLoading();
    var result = await locator<Repository>().logIn(
      requestBody: _getRequestForLogIn(),
    );
    hideLoading();
    result.fold(
      (failure) {},
      (response) {},
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
