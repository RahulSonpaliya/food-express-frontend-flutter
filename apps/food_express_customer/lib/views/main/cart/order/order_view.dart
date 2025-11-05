import 'package:flutter/material.dart';
import 'package:shared/colors.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import 'order_viewmodel.dart';

class OrderView extends StatelessWidget {
  final num orderId;
  const OrderView(this.orderId);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderViewModel>.reactive(
        builder: (_, model, child) {
          return WillPopScope(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                titleSpacing: 0,
                leading: GestureDetector(
                    onTap: model.navigateBack, child: const Icon(Icons.close)),
              ),
              body: SafeArea(
                child: ListView(
                  padding: EdgeInsets.only(top: 40, left: 40, right: 40),
                  shrinkWrap: true,
                  children: [
                    // TODO add image
                    // Center(
                    //   child: Image.asset('assets/ic_order_done.png'),
                    // ),
                    SizedBox(
                      height: 28,
                    ),
                    Center(
                      child: Text(
                        'Order Successful!',
                        style: TSB.boldHeading(textColor: black_text_color),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        'Your order was placed successfully. For more details, check Delivery status under my orders.',
                        style:
                            TSB.regularMedium(textColor: grey_sub_text_color),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Container(
                      child: _buildTrackOrderButton(model),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
            onWillPop: () async {
              model.navigateBack();
              return false;
            },
          );
        },
        viewModelBuilder: () => OrderViewModel(orderId));
  }

  _buildTrackOrderButton(OrderViewModel model) {
    return MaterialButton(
      onPressed: model.navigateToOrderDetail,
      color: theme_blue_color_1,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Track Order',
            style: TSB.boldSmall(textColor: Colors.white),
          ),
          SizedBox(
            width: 5,
          ),
          // TODO add icon
          // Image.asset('assets/ic_get_started.png')
        ],
      ),
    );
  }
}
