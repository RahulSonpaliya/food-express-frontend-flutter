import 'package:flutter/material.dart';
import 'package:shared/app_theme.dart';

import 'views/splash/splash_view.dart';

void main() {
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
      theme: AppTheme.appTheme,
      home: SplashView(),
    );
  }
}
