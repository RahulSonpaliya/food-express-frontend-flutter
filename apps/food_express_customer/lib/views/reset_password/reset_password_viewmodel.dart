import 'package:shared/common_utils.dart';
import 'package:shared/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../data/remote/repository.dart';
import '../login/login_view.dart';

class ResetPasswordViewModel extends BaseViewModel {
  final String countryCode;
  final String phoneNumber;
  String password = "";
  String confirmPassword = "";

  ResetPasswordViewModel({
    required this.countryCode,
    required this.phoneNumber,
  });

  final _navigationService = locator.get<NavigationService>();

  navigateToLogin() {
    _navigationService.clearStackAndShowView(LoginView());
  }

  submit() async {
    showLoading();
    var result = await locator<Repository>().resetPassword(
      requestBody: _getRequestForResetPassword(),
    );
    hideLoading();
    result.fold(
      (failure) => handleFailure(failure),
      (response) => showDialog(
        response.message,
        okBtnClick: navigateToLogin,
      ),
    );
  }

  Map<String, String> _getRequestForResetPassword() {
    Map<String, String> request = {};
    request['countryCode'] = countryCode;
    request['phoneNumber'] = phoneNumber;
    request['password'] = password;
    request['confirmPassword'] = confirmPassword;
    request['accountType'] = acTypeCustomer;
    return request;
  }
}
