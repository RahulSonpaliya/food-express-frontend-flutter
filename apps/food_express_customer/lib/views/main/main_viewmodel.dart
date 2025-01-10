import 'package:food_express_customer/views/login/login_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/locator.dart';
import '../../data/model/bean/user.dart';

class MainViewModel extends BaseViewModel {
  final _navigationService = locator.get<NavigationService>();
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  MainViewModel() {
    if (appUser.value != null) {
      _getCartData();
    }
    // TODO: implement
    // _handleNotifications();
  }

  updateTabIndex(i) {
    _tabIndex = i;
    notifyListeners();
  }

  navigateToLogin() {
    _navigationService.navigateWithTransition(LoginView(fromInside: true),
        transitionStyle: Transition.rightToLeft);
  }

  _getCartData() async {
    // TODO: implement
  }
}
