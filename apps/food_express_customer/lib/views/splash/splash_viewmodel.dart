import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => _proceedToNextScreen(),
    );
  }

  _proceedToNextScreen() {
    // TODO implement
  }
}
