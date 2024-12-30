import 'package:flutter/material.dart';
import 'package:shared/app/locator.dart';
import 'package:shared/colors.dart';
import 'package:shared/data/local/app_shared_prefs.dart';
import 'package:shared/data/local/preference_keys.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked_services/stacked_services.dart';

import '../login/login_view.dart';

class WalkThoroughView extends StatefulWidget {
  const WalkThoroughView({super.key});

  @override
  _WalkThoroughViewState createState() => _WalkThoroughViewState();
}

class _WalkThoroughViewState extends State<WalkThoroughView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: PageView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: 3,
                onPageChanged: (int page) {
                  getChangedPageAndMoveBar(page);
                },
                itemBuilder: (context, index) {
                  var intro = IntroModel.intro[index];
                  return Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Image.asset(
                          intro.image,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              intro.title,
                              style: TSB.boldHeading(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              intro.subtitle,
                              style: TSB.regularMedium(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < 3; i++)
                        if (i == currentPageValue) ...[circleBar(true)] else
                          circleBar(false),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: (currentPageValue == 0 || currentPageValue == 1)
                        ? _skipBtn()
                        : _getStartedBtn(),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  _skipBtn() {
    return MaterialButton(
      onPressed: _navigateToLogin,
      color: colorWhite,
      elevation: 0,
      height: 50,
      child: Text(
        'Skip',
        style: TSB.regularLarge(textColor: theme_blue_color_1),
      ),
    );
  }

  _navigateToLogin() async {
    await AppSharedPrefs.get().addBoolean(PreferenceKeys.FIRST_TIME, false);
    locator.get<NavigationService>().replaceWithTransition(LoginView(),
        transitionStyle: Transition.rightToLeft);
  }

  _getStartedBtn() {
    return MaterialButton(
      onPressed: _navigateToLogin,
      color: theme_blue_color_1,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Get Started',
            style: TSB.semiBoldSmall(textColor: Colors.white),
          ),
        ],
      ),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;

    if (previousPageValue == 0) {
      previousPageValue = currentPageValue;
      _moveBar = _moveBar + 0.14;
    } else {
      if (previousPageValue < currentPageValue) {
        previousPageValue = currentPageValue;
        _moveBar = _moveBar + 0.14;
      } else {
        previousPageValue = currentPageValue;
        _moveBar = _moveBar - 0.14;
      }
    }

    setState(() {});
  }

  int currentPageValue = 0;
  int previousPageValue = 0;
  double _moveBar = 0.0;

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 15 : 10,
      width: isActive ? 15 : 10,
      decoration: BoxDecoration(
          border: isActive
              ? Border.all(width: 2, color: theme_blue_color_1)
              : Border.all(color: Colors.grey),
          color: isActive ? Colors.transparent : Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
    );
  }
}

class IntroModel {
  final String image, title, subtitle;

  IntroModel(this.image, this.title, this.subtitle);

  static var intro = [
    IntroModel('assets/ic_walkthrough_01.png', 'Shop Smarter with Us',
        'Fresh Picks, Fast Service, Every Time'),
    IntroModel('assets/ic_walkthrough_02.png', 'Add Your Address',
        'Discover Nearby Stores Tailored to Your Needs'),
    IntroModel('assets/ic_walkthrough_03.png', 'Get It Delivered',
        'Freshness Delivered with Speed'),
  ];
}
