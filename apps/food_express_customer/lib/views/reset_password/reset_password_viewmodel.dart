import 'package:stacked/stacked.dart';

class ResetPasswordViewModel extends BaseViewModel {
  final String countryCode;
  final String phoneNumber;
  String password = "";
  String confirmPassword = "";

  ResetPasswordViewModel({
    required this.countryCode,
    required this.phoneNumber,
  });

  submit() async {
    //TODO : implement api call
  }
}
