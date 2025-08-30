import 'package:flutter/material.dart';
import 'package:shared/colors.dart';
import 'package:shared/text_styles.dart';

import '../../../data/model/bean/market.dart';

class StoreDistanceWidget extends StatelessWidget {
  final Market market;
  final Future<String> calculateDistance;
  const StoreDistanceWidget({
    super.key,
    required this.market,
    required this.calculateDistance,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: calculateDistance,
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
