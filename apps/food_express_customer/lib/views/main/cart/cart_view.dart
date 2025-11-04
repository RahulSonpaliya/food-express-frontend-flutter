import 'package:flutter/material.dart';
import 'package:shared/colors.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import '../../../data/model/bean/order.dart';
import 'cart_product_list.dart';
import 'cart_viewmodel.dart';

class CartView extends StatefulWidget {
  bool navigatedFromHome;
  CartView({this.navigatedFromHome = false});
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CardViewModel>.reactive(
        builder: (_, model, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: widget.navigatedFromHome
                  ? null
                  : IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: model.navigateBack,
                    ),
              title: Text(
                'My Cart',
                style: TSB.boldMedium(textColor: black_text_color),
              ),
              titleSpacing: widget.navigatedFromHome
                  ? NavigationToolbar.kMiddleSpacing
                  : 0,
            ),
            backgroundColor: Colors.white,
            body: model.busy(model.loading) ? _loadingView() : _content(model),
          );
        },
        viewModelBuilder: () => CardViewModel());
  }

  _content(CardViewModel model) {
    return ValueListenableBuilder(
        valueListenable: appOrderFromServer,
        builder: (_, Order? order, child) {
          if (order == null || order.carts.isEmpty) {
            return Center(
              child: Text(
                'Cart is empty',
                style: TSB.regularSmall(),
              ),
            );
          }
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            children: [
              Container(child: CartProductList(order)),
              SizedBox(
                height: 15,
              ),
              Text(
                'Receipt',
                style: TSB.boldXLarge(textColor: black_text_color),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: cart_item_background_color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(28, 10, 28, 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Subtotal',
                                style: TSB.regularSmall(
                                    textColor: grey_sub_text_color),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(28, 10, 28, 10),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                '\$${order?.total?.toStringAsFixed(2) ?? '0'}',
                                style: TSB.regularSmall(
                                    textColor: grey_sub_text_color),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(28, 10, 28, 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Delivery',
                                style: TSB.regularSmall(
                                    textColor: grey_sub_text_color),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(28, 10, 28, 10),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                '\$${order?.deliveryFee?.toStringAsFixed(2) ?? '0'}',
                                style: TSB.regularSmall(
                                    textColor: grey_sub_text_color),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 29),
                      child: Divider(
                        color: cart_item_divider_color,
                        height: 20,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(28, 10, 28, 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Total',
                                style:
                                    TSB.boldMedium(textColor: black_text_color),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(28, 5, 20, 10),
                              child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.end,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Text(
                                        _getItemsCount(order),
                                        style: TSB.regularSmall(
                                            textColor: grey_sub_text_color),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '\$${_getOrderTotal(order)}',
                                    style: TSB.boldXLarge(
                                        textColor: blue_button_color),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(child: _proceedToCheckoutBtn(model)),
              SizedBox(
                height: 24,
              ),
            ],
          );
        });
  }

  _getOrderTotal(Order? order) {
    if (order != null) {
      return (order.total + order.deliveryFee).toStringAsFixed(2);
    }
    return 0;
  }

  _getItemsCount(Order? order) {
    if (order != null && order.carts.isNotEmpty) {
      return '(${order.carts.length} ${order.carts.length > 1 ? 'Items' : 'Item'})';
    }
    return '';
  }

  _loadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _proceedToCheckoutBtn(CardViewModel model) {
    return MaterialButton(
      onPressed: model.proceedToCheckOutClick,
      color: theme_blue_color_1,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Proceed To Checkout',
            style: TSB.boldSmall(textColor: Colors.white),
          ),
          SizedBox(
            width: 5,
          ),
          Image.asset('assets/ic_get_started.png')
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
