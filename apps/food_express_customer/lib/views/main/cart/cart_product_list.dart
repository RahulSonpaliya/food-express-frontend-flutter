import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/plus_minus_btn.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import '../../../data/model/bean/order.dart';
import 'cart_viewmodel.dart';

class CartProductList extends ViewModelWidget<CardViewModel> {
  Order order;
  CartProductList(this.order);
  @override
  Widget build(BuildContext context, CardViewModel model) {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (_, i) {
          var cart = order.carts[i];
          var cartItem = cart.cartItem;
          var p = cartItem.product;
          return Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        imageUrl: p.image ?? '',
                        fit: BoxFit.cover,
                        placeholder: (_, url) => Image.asset(
                          AppImages.defaultImage,
                          width: 85,
                          height: 85,
                        ),
                        width: 85,
                        height: 85,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.name,
                              style: TSB.semiBoldMedium(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            cartItem.option != null
                                ? Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          cartItem.option!.variant_name,
                                          style: TSB.regularSmall(
                                              textColor: theme_text_hint_color),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            Text(
                              '\$${p.price}',
                              style: TSB.semiBoldSmall(
                                  textColor: theme_blue_color_1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                PlusMinusBtn(
                  plusClick: () => model.plusClick(cart),
                  minusClick: () => model.minusClick(cart),
                  showMinus: true,
                  qty: '${cartItem.qty}',
                )
              ],
            ),
          );
        },
        separatorBuilder: (_, i) {
          return Padding(
            padding: EdgeInsets.only(left: 85 + 15, top: 5, bottom: 10),
            child: Container(
              height: 1,
              color: Colors.grey[300],
            ),
          );
        },
        itemCount: order.carts.length);
  }
}
