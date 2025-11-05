import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/locator.dart';
import '../../main_view.dart';

class OrderViewModel extends BaseViewModel {
  final _navigationService = locator.get<NavigationService>();

  final num orderId;
  OrderViewModel(this.orderId);

  navigateBack() {
    MainView.startMainScreen();
  }

  navigateToOrderDetail() {
    // TODO implement
    // Get.offAll(
    //     OrderDetailView(
    //       navigatedFromOrderSuccess: true,
    //       orderId: orderId,
    //     ),
    //     transition: Transition.rightToLeft);
  }

  closeClick() {
    // _navigationService.pushNamedAndRemoveUntil(HomeView(),)
  }
}
