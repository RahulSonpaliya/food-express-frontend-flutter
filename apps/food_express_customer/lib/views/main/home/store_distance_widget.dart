import 'package:flutter/material.dart';
import 'package:food_express_customer/views/main/home/home_viewmodel.dart';
import 'package:shared/colors.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import '../../../data/model/bean/market.dart';

class StoreDistanceWidget extends ViewModelWidget<HomeViewModel> {
  final Market market;
  const StoreDistanceWidget({super.key, required this.market});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return FutureBuilder<String>(
      future: viewModel.calculateDistance(market),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data ?? '',
            style: TSB.semiBoldSmall(textColor: black_text_color),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
