import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/decoration.dart';
import 'package:shared/size_config.dart';
import 'package:shared/start_rating_view.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import '../../../../data/model/bean/order.dart';
import 'checkout_viewmodel.dart';

class CheckOutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckOutViewModel>.reactive(
        builder: (_, model, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: model.navigateBack,
                icon: Icon(Icons.arrow_back),
              ),
              title: Text(
                'Checkout',
                style: TSB.boldMedium(textColor: black_text_color),
              ),
              titleSpacing: 0,
            ),
            backgroundColor: Colors.white,
            body: model.busy(model.selectedAddress)
                ? _loadingView()
                : _content(model),
          );
        },
        viewModelBuilder: () => CheckOutViewModel());
  }

  final FocusNode _tipFocusNode = FocusNode();

  _content(CheckOutViewModel model) {
    return SafeArea(
      child: KeyboardActions(
        config: KeyboardActionsConfig(
            keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
            keyboardBarColor: Colors.grey[200],
            nextFocus: false,
            actions: [
              KeyboardActionsItem(
                focusNode: _tipFocusNode,
              ),
            ]),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
              top: SizeConfig.margin_padding_15,
              left: SizeConfig.margin_padding_15,
              right: SizeConfig.margin_padding_15),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Order Details',
                style: TSB.boldLarge(textColor: black_text_color),
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            ListTile(
              leading: ClipRRect(
                borderRadius:
                    BorderRadius.circular(SizeConfig.margin_padding_5),
                child: CachedNetworkImage(
                  imageUrl: appOrderFromServer.value?.market.image ?? '',
                  fit: BoxFit.cover,
                  placeholder: (_, url) => Image.asset(
                    'assets/default_image.png',
                    width: SizeConfig.margin_padding_50,
                    height: SizeConfig.margin_padding_50,
                  ),
                  width: SizeConfig.margin_padding_50,
                  height: SizeConfig.margin_padding_50,
                ),
              ),
              title: Text(
                appOrderFromServer.value?.market.name ?? '',
                maxLines: 2,
                style: TSB.boldMedium(textColor: black_text_color),
              ),
              dense: true,
              contentPadding: EdgeInsets.zero,
              trailing: appOrderFromServer.value?.market.rating != null
                  ? SizedBox(
                      width: SizeConfig.margin_padding_50 +
                          SizeConfig.margin_padding_5,
                      child: StarRatingView(
                          rating: appOrderFromServer.value!.market.rating!
                              .toDouble()))
                  : null,
            ),
            Divider(
              color: cart_item_divider_color,
              height: SizeConfig.margin_padding_35,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                '${appOrderFromServer.value?.carts.length} ${(appOrderFromServer.value?.carts.length ?? 0) > 1 ? 'Items' : 'Item'}',
                style: TSB.regularSmall(textColor: grey_sub_text_color),
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_10,
            ),
            Container(
              child: _buildVerticalItemList(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            _deliveryAddressView(model),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Tip For Delivery Partners',
                style: TSB.boldLarge(textColor: black_text_color),
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_15,
            ),
            Container(
              child: _buildHorizontalTipView(model),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_20,
            ),
            TextField(
              style: TSB.regularSmall(),
              controller: model.tipCtrl,
              focusNode: _tipFocusNode,
              onChanged: (val) {
                num tipVal = 0;
                if (val.isNotEmpty) {
                  tipVal = int.parse(val);
                }
                model.updateTip(tipVal, updateTextField: false);
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]"))
              ],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              decoration: textFieldDecorationAmount.copyWith(
                hintText: 'Enter Amount',
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_24,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Receipt',
                style: TSB.boldLarge(textColor: black_text_color),
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_15,
            ),
            Container(
              child: _buildRecieptView(model),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_24,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Payment Method',
                style: TSB.boldLarge(textColor: black_text_color),
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_15,
            ),
            Container(
              child: _buildPaymentView(model),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_24,
            ),
            Container(
              child: _buildOrderNowButton(model),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_24,
            ),
          ],
        ),
      ),
    );
  }

  _loadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _deliveryAddressView(CheckOutViewModel model) {
    if (model.selectedAddress == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Delivery Address',
            style: TSB.boldLarge(textColor: black_text_color),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_5,
          ),
          TextButton(
              onPressed: model.navigateToMyAddress,
              child: Text(
                'Add Delivery Address',
                style: TSB.regularMedium(textColor: Colors.red),
              )),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Delivery Address',
            style: TSB.boldLarge(textColor: black_text_color),
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_15,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConfig.margin_padding_5),
            color: cart_item_background_color,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    SizeConfig.margin_padding_15,
                    SizeConfig.margin_padding_15,
                    SizeConfig.margin_padding_15,
                    0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    model.selectedAddress?.addressNickName ?? "",
                    style: TSB.boldSmall(textColor: black_text_color),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.margin_padding_15,
                          right: SizeConfig.margin_padding_10,
                          top: SizeConfig.margin_padding_10),
                      child: Text(
                        model.selectedAddress?.address ?? "",
                        style: TSB.regularSmall(textColor: grey_sub_text_color),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.margin_padding_10,
                        right: SizeConfig.margin_padding_15,
                        top: SizeConfig.margin_padding_10),
                    child: Material(
                      color: cart_item_background_color,
                      borderRadius:
                          BorderRadius.circular(SizeConfig.margin_padding_5),
                      elevation: SizeConfig.margin_padding_8,
                      child: InkWell(
                        child: Image.asset('assets/ic_edit.png'),
                        onTap: model.navigateToMyAddress,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: SizeConfig.margin_padding_20),
            ],
          ),
        ),
      ],
    );
  }

  _buildVerticalItemList() {
    return SizedBox(
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: appOrderFromServer.value?.carts.length ?? 0,
        separatorBuilder: (_, i) {
          return Padding(
            padding: EdgeInsets.only(
                left:
                    SizeConfig.margin_padding_85 + SizeConfig.margin_padding_15,
                top: SizeConfig.margin_padding_5,
                bottom: SizeConfig.margin_padding_10),
            child: Container(
              height: SizeConfig.separatorWidth,
              color: cart_item_divider_color,
            ),
          );
        },
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardListItem(index),
          ],
        ),
      ),
    );
  }

  _tipButton(CheckOutViewModel model, num tip, String title, bool isSelected) {
    return Container(
      height: SizeConfig.margin_padding_40 + SizeConfig.margin_padding_5,
      width: SizeConfig.margin_padding_70 + SizeConfig.margin_padding_5,
      color: isSelected ? colorBlack : colorWhite,
      child: Builder(
        builder: (_) {
          return OutlinedButton(
            onPressed: () {
              hideKeyboard(_);
              model.updateTip(tip);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: isSelected ? theme_text_fill_color : Colors.grey[300]!,
              ),
              backgroundColor: isSelected ? colorBlack : Colors.grey[300],
            ),
            child: Text(
              title,
              style: isSelected
                  ? TSB.semiBoldVSmall(textColor: colorWhite)
                  : TSB.semiBoldVSmall(textColor: theme_text_hint_color),
            ),
          );
        },
      ),
    );
  }

  _buildHorizontalTipView(CheckOutViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _tipButton(model, 5, '\$5', model.tip == 5),
        SizedBox(
          width: SizeConfig.margin_padding_5,
        ),
        _tipButton(model, 10, '\$10', model.tip == 10),
        SizedBox(
          width: SizeConfig.margin_padding_5,
        ),
        _tipButton(model, 15, '\$15', model.tip == 15),
        SizedBox(
          width: SizeConfig.margin_padding_5,
        ),
        _tipButton(model, 0, 'Other',
            model.tip != 5 && model.tip != 10 && model.tip != 15),
      ],
    );
  }

  _buildRecieptView(CheckOutViewModel model) {
    return Container(
      color: cart_item_background_color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_15,
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Subtotal',
                      style: TSB.regularSmall(textColor: grey_sub_text_color),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_15,
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      '\$${appOrderFromServer.value?.total.toStringAsFixed(2)}',
                      style: TSB.regularSmall(textColor: grey_sub_text_color),
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
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_5,
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Delivery',
                      style: TSB.regularSmall(textColor: grey_sub_text_color),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_5,
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      '\$${appOrderFromServer.value?.deliveryFee.toStringAsFixed(2)}',
                      style: TSB.regularSmall(textColor: grey_sub_text_color),
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
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_5,
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Tip Amount',
                      style: TSB.regularSmall(textColor: grey_sub_text_color),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_5,
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      '\$${model.tip}',
                      style: TSB.regularSmall(textColor: grey_sub_text_color),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: SizeConfig.margin_padding_29),
            child: Divider(
              color: cart_item_divider_color,
              height: SizeConfig.margin_padding_20,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_10,
                      SizeConfig.margin_padding_28,
                      SizeConfig.margin_padding_10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Total',
                      style: TSB.boldMedium(textColor: black_text_color),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.margin_padding_28,
                          SizeConfig.margin_padding_5,
                          SizeConfig.margin_padding_20,
                          SizeConfig.margin_padding_10),
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.end,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.margin_padding_4),
                              child: Text(
                                '(${appOrderFromServer.value?.carts.length} ${(appOrderFromServer.value?.carts.length ?? 0) > 1 ? 'Items' : 'Item'})',
                                style: TSB.regularSmall(
                                    textColor: grey_sub_text_color),
                              )),
                          SizedBox(
                            width: SizeConfig.margin_padding_10,
                          ),
                          Text(
                            '\$${((appOrderFromServer.value?.total ?? 0) + (appOrderFromServer.value?.deliveryFee ?? 0) + model.tip).toStringAsFixed(2)}',
                            style: TSB.boldXLarge(textColor: blue_button_color),
                          ),
                        ],
                      )))
            ],
          ),
        ],
      ),
    );
  }

  _buildPaymentView(CheckOutViewModel model) {
    if (model.card == null) {
      return Material(
        color: cart_item_background_color,
        child: InkWell(
          onTap: model.addCardClick,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: SizeConfig.margin_padding_28,
                ),
                Container(child: Image.asset('assets/ic_add_card.png')),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.margin_padding_20,
                          SizeConfig.margin_padding_15,
                          SizeConfig.margin_padding_10,
                          0),
                      child: Text(
                        'Add Card',
                        textAlign: TextAlign.start,
                        style: TSB.boldSmall(textColor: blue_button_color),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.margin_padding_20,
                          SizeConfig.margin_padding_5,
                          SizeConfig.margin_padding_10,
                          SizeConfig.margin_padding_10),
                      child: Text(
                        'xxxx xxxx xxxx xxxx',
                        style: TSB.regularSmall(textColor: blue_button_color),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Material(
        color: cart_item_background_color,
        child: InkWell(
          onTap: model.addCardClick,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: SizeConfig.margin_padding_28,
              ),
              Image.asset('assets/ic_add_card.png'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        SizeConfig.margin_padding_20,
                        SizeConfig.margin_padding_15,
                        SizeConfig.margin_padding_10,
                        0),
                    child: Text(
                      'xxxx xxxx xxxx ${model.card.last_four_digit}',
                      textAlign: TextAlign.start,
                      style: TSB.boldSmall(textColor: blue_button_color),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        SizeConfig.margin_padding_20,
                        SizeConfig.margin_padding_5,
                        SizeConfig.margin_padding_10,
                        SizeConfig.margin_padding_10),
                    child: Text(
                      '${model.card.card_holder}',
                      style: TSB.regularSmall(textColor: blue_button_color),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }

  _buildOrderNowButton(CheckOutViewModel model) {
    return MaterialButton(
      onPressed: (model.selectedAddress == null /* || model.card == null*/)
          ? null
          : model.orderNowClick,
      color: theme_blue_color_1,
      disabledColor: Colors.grey,
      height: SizeConfig.margin_padding_50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Order Now',
            style: TSB.boldSmall(textColor: Colors.white),
          ),
          SizedBox(
            width: SizeConfig.margin_padding_5,
          ),
          Image.asset('assets/ic_get_started.png')
        ],
      ),
    );
  }

  _buildCardListItem(index) {
    var cartItem = appOrderFromServer.value?.carts[index].cartItem;
    var p = cartItem?.product;
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: p?.image ?? "",
                  fit: BoxFit.cover,
                  placeholder: (_, url) => Image.asset(
                    AppImages.defaultImage,
                    width: SizeConfig.margin_padding_85,
                    height: SizeConfig.margin_padding_85,
                  ),
                  width: SizeConfig.margin_padding_85,
                  height: SizeConfig.margin_padding_85,
                ),
                SizedBox(
                  width: SizeConfig.margin_padding_15,
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p?.name ?? "",
                        style: TSB.semiBoldMedium(),
                      ),
                      SizedBox(
                        height: SizeConfig.margin_padding_5,
                      ),
                      cartItem?.option != null
                          ? Column(
                              children: [
                                Text(
                                  cartItem!.option!.variant_name,
                                  style: TSB.regularSmall(
                                      textColor: theme_text_hint_color),
                                ),
                                SizedBox(
                                  height: SizeConfig.margin_padding_5,
                                ),
                              ],
                            )
                          : Container(),
                      Text(
                        '\$${p?.price.toStringAsFixed(2)}',
                        style: TSB.semiBoldSmall(textColor: theme_blue_color_1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.clear,
                color: Colors.grey[400],
              ),
              SizedBox(
                width: SizeConfig.margin_padding_5,
              ),
              Text(
                '${cartItem?.qty}',
                style: TSB.regularSmall(textColor: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
