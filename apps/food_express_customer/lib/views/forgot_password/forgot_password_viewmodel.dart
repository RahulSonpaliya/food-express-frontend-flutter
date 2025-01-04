import 'package:stacked/stacked.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  String mobile = '';
  String _selectedCCode = '+1';
  String get selectedCCode => _selectedCCode;

  updateCountryCode(String val) {
    _selectedCCode = val;
    notifyListeners();
  }
}
