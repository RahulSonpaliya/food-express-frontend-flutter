import 'package:shared/app/locator.dart';
import 'package:shared/data/local/app_shared_prefs.dart';
import 'package:shared/data/local/preference_keys.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
    // TODO implement
    // _navigationService.replaceWithTransition(const SignUpView(),
    //     transitionStyle: Transition.rightToLeft);
  }

  login() async {
    // TODO implement
  }

  Future<Map<String, String>> _getRequestForLogIn(
      String selectedCCode, String phoneNumber, String password) async {
    Map<String, String> request = {};
    // request['country_code'] = selectedCCode;
    // request['phone_number'] = phoneNumber;
    // request['password'] = password;
    // request['device_id'] = await Repository.get().getFCMToken();
    // request['device_type'] = getDeviceType();
    // request['certification_type'] = getCertificationType();
    // request['version'] = await getVersionName();
    // request['user_type'] = USER_TYPE;
    // printMsg("getRequestForLogIn :: $request");
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
