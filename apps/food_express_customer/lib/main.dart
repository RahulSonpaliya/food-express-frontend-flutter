import 'package:flutter/material.dart';
import 'package:shared/app/dialogs.dart';
import 'package:shared/app/locator.dart';
import 'package:shared/app_theme.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/locator.dart';
import 'views/splash/splash_view.dart';

void main() {
  setupLocator();
  setupLocatorCustomerApp();
  setupDialogUi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Express Customer',
      debugShowCheckedModeBanner: false,
      navigatorKey: StackedService.navigatorKey,
      theme: AppTheme.appTheme,
      home: SplashView(),
    );
  }
}
