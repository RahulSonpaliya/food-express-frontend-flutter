import 'package:get/get.dart';
import 'package:shared/data/local/app_shared_prefs.dart';
import 'package:shared/data/local/preference_keys.dart';
import 'package:stacked/stacked.dart';

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
                    // TODO
                    //navigate to location screen
                    // Get.offAll(LocationView(), transition: Transition.rightToLeft);
                  } else {
                    // TODO
                    //navigate to home screen
                    // MainView.startMainScreen();
                  }
                });
              } else {
                Get.offAll(LoginView(), transition: Transition.rightToLeft);
              }
            });
          } else {
            // TODO
            // AppSharedPrefs.get()
            //     .getValue(PreferenceKeys.USER_ADDRESS_DATA)
            //     .then((value) async {
            //   if (value == null) {
            //     //navigate to location screen
            //     UserBean userBean = await UserBean.getSavedUser();
            //     appUser.value = userBean;
            //     Get.offAll(LocationView(), transition: Transition.rightToLeft);
            //   } else {
            //     //navigate to home screen
            //     UserBean userBean = await UserBean.getSavedUser();
            //     appUser.value = userBean;
            //     UserAddressBean userAddressBean =
            //     await UserAddressBean.getSavedUser();
            //     appUserAddress.value = userAddressBean;
            //     MainView.startMainScreen();
            //   }
            // });
          }
        });
      }
    });
  }
}
