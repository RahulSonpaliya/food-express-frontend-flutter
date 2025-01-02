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
}
