import 'package:flutter/material.dart';
import 'package:shared/app_images.dart';
import 'package:shared/size_config.dart';
import 'package:stacked/stacked.dart';

import 'splash_viewmodel.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState
    extends State<SplashView> /*with WidgetsBindingObserver*/ {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      builder: (_, model, child) {
        return Scaffold(
          body: Center(
            child: Image.asset(AppImages.splashBg),
          ),
        );
      },
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}

// class SplashView extends StackedView<SplashViewModel> {
//   const SplashView({super.key});
//
//   @override
//   Widget builder(
//     BuildContext context,
//     SplashViewModel viewModel,
//     Widget? child,
//   ) {
//     return Scaffold(
//       body: Center(
//         child: Image.asset(AppImages.splashBg),
//       ),
//     );
//   }
//
//   @override
//   SplashViewModel viewModelBuilder(BuildContext context) => SplashViewModel();
//
//   @override
//   bool get reactive => false;
// }
