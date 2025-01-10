import 'package:flutter/material.dart';
import 'package:shared/colors.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import '../../data/model/bean/user.dart';
import 'cart/cart_view.dart';
import 'home/home_view.dart';
import 'main_viewmodel.dart';
import 'more/more_view.dart';
import 'notification/notification_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
        builder: (_, model, child) {
          return PopScope(
            canPop: false,
            child: Scaffold(
              body: SafeArea(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                      child: TabBarView(
                        controller: _tabController,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          HomeView(),
                          NotificationView(),
                          CartView(),
                          MoreView(),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomNavBar(
                        onTap: (i) {
                          if (appUser.value != null) {
                            _tabController.animateTo(i);
                            model.updateTabIndex(i);
                          } else {
                            model.navigateToLogin();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            // TODO: implement
            // onWillPop: () async {
            //   if (_tabController.index == 0) {
            //     model.showAppExitDialog();
            //   } else {
            //     _tabController.animateTo(0);
            //     model.updateTabIndex(0);
            //   }
            //   return false;
            // },
          );
        },
        viewModelBuilder: () => MainViewModel());
  }
}

class BottomNavBar extends ViewModelWidget<MainViewModel> {
  final ValueChanged<int> onTap;

  const BottomNavBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context, MainViewModel model) {
    return BottomNavigationBar(
      items: _renderBottomTabBar(),
      currentIndex: model.tabIndex,
      backgroundColor: Colors.white,
      elevation: 24,
      iconSize: 18,
      selectedItemColor: theme_blue_color_1,
      selectedLabelStyle: TSB.regularSmall(),
      unselectedLabelStyle: TSB.regularSmall(),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
    );
  }

  List<BottomNavigationBarItem> _renderBottomTabBar() {
    var home = BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    );

    var notification = BottomNavigationBarItem(
      icon: Icon(Icons.notifications_outlined),
      activeIcon: Icon(Icons.notifications),
      label: 'Notification',
    );

    // TODO: implement
    // var order = BottomNavigationBarItem(
    //   icon: ValueListenableBuilder(
    //     valueListenable: appOrderFromServer,
    //     builder: (_, Order order, child) {
    //       return appOrderFromServer.value != null
    //           ? Badge(
    //               toAnimate: true,
    //               showBadge:
    //                   appOrderFromServer.value.carts.length == 0 ? false : true,
    //               animationType: BadgeAnimationType.fade,
    //               badgeContent: Text(
    //                 appOrderFromServer.value.carts.length.toString() ?? '  ',
    //                 style: TSB.regularVSmall(textColor: Colors.white),
    //               ),
    //               child: Icon(Icons.shopping_cart),
    //             )
    //           : Icon(Icons.shopping_cart);
    //     },
    //   ),
    //   activeIcon: Icon(Icons.shopping_cart_outlined),
    //   label: 'Cart',
    // );

    var order = BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      activeIcon: Icon(Icons.shopping_cart_outlined),
      label: 'Cart',
    );

    var more = BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      activeIcon: Icon(Icons.settings),
      label: 'More',
    );

    return [home, notification, order, more];
  }
}
