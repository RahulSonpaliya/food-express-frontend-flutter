import 'package:food_express_customer/views/location/location_view.dart';
import 'package:food_express_customer/views/main/main_view.dart';
import 'package:get/get.dart';
import 'package:shared/data/local/app_shared_prefs.dart';
import 'package:shared/data/local/preference_keys.dart';
import 'package:stacked/stacked.dart';

import '../../data/model/bean/user.dart';
import '../../data/model/bean/user_address.dart';
import '../login/login_view.dart';
import '../walkthrough/walkthrough_view.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => _proceedToNextScreen(),
    );
  }

  _proceedToNextScreen() {
    AppSharedPrefs.get()
        .getBoolean(PreferenceKeys.FIRST_TIME)
        .then((firstTime) {
      if (firstTime ?? true) {
        Get.offAll(() => const WalkThoroughView(),
            transition: Transition.rightToLeft);
      } else {
        AppSharedPrefs.get()
            .getValue(PreferenceKeys.ACCESS_TOKEN)
            .then((token) async {
          if (token == null) {
            AppSharedPrefs.get()
                .getBoolean(PreferenceKeys.GUEST_USER)
                .then((value) {
              if (value ?? false) {
                //already logged in as guest
                AppSharedPrefs.get()
                    .getValue(PreferenceKeys.USER_ADDRESS_DATA)
                    .then((value) async {
                  if (value == null) {
                    Get.offAll(() => const LocationView(),
                        transition: Transition.rightToLeft);
                  } else {
                    Get.offAll(() => const MainView(),
                        transition: Transition.rightToLeft);
                  }
                });
              } else {
                Get.offAll(() => LoginView(),
                    transition: Transition.rightToLeft);
              }
            });
          } else {
            AppSharedPrefs.get()
                .getValue(PreferenceKeys.USER_ADDRESS_DATA)
                .then((value) async {
              if (value == null) {
                //navigate to location screen
                User userBean = await User.getSavedUser();
                appUser.value = userBean;
                Get.offAll(LocationView(), transition: Transition.rightToLeft);
              } else {
                //navigate to home screen
                User userBean = await User.getSavedUser();
                appUser.value = userBean;
                UserAddress userAddressBean =
                    await UserAddress.getSavedUserAddress();
                appUserAddress.value = userAddressBean;
                Get.offAll(() => const MainView(),
                    transition: Transition.rightToLeft);
              }
            });
          }
        });
      }
    });
  }
}
