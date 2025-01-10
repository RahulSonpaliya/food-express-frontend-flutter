import 'package:food_express_customer/views/login/login_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';

class MainViewModel extends BaseViewModel {
  final _navigationService = locator.get<NavigationService>();
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  updateTabIndex(i) {
    _tabIndex = i;
    notifyListeners();
  }

  navigateToLogin() {
    _navigationService.navigateWithTransition(LoginView(fromInside: true),
        transitionStyle: Transition.rightToLeft);
  }
}
