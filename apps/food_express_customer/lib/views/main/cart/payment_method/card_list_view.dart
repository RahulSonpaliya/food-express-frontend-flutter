import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared/colors.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/size_config.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import 'payment_method_viewmodel.dart';

class CardListView extends ViewModelWidget<PaymentMethodViewModel> {
  final addNewCardClick;

  CardListView(this.addNewCardClick);

  @override
  Widget build(BuildContext context, PaymentMethodViewModel model) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: ListView.separated(
              padding: EdgeInsets.all(SizeConfig.margin_padding_20),
              shrinkWrap: true,
              itemBuilder: (_, i) {
                var card = model.cards![i];
                return Material(
                  child: InkWell(
                    child: ListTileTheme(
                      contentPadding:
                          EdgeInsets.all(SizeConfig.margin_padding_5),
                      child: RadioListTile(
                        value: card.id,
                        groupValue: model.selectedCard?.id,
                        onChanged: (val) async {
                          model.updatedSelectedCard(card);
                          await Future.delayed(Duration(milliseconds: 200));
                          model.selectCardForPayment(card);
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Card no. - xxxx xxxx xxxx ${card.last_four_digit}',
                                    style: TSB.regularSmall(),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.margin_padding_2,
                                  ),
                                  Text('Name on Card - ${card.card_holder}',
                                      style: TSB.regularSmall()),
                                ],
                              ),
                            ),
                            Expanded(
                                child: CupertinoButton(
                                    minSize: 22,
                                    child: Image.asset(
                                      'assets/ic_delete.png',
                                      color: Colors.red,
                                      height: 18,
                                      width: 18,
                                    ),
                                    onPressed: () => model.confirmDelete(card),
                                    padding: EdgeInsets.zero))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, i) => Container(
                    height: SizeConfig.margin_padding_10,
                  ),
              itemCount: model.cards?.length ?? 0),
        ),
        Container(
          margin: EdgeInsets.only(bottom: SizeConfig.margin_padding_10),
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.margin_padding_20),
          child: MaterialButton(
            onPressed: () {
              hideKeyboard(context);
              addNewCardClick();
            },
            color: theme_blue_color_1,
            height: SizeConfig.margin_padding_50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Add New Card',
                  style: TSB.boldSmall(textColor: Colors.white),
                ),
                SizedBox(
                  width: SizeConfig.margin_padding_5,
                ),
                Image.asset('assets/ic_get_started.png')
              ],
            ),
          ),
        )
      ],
    );
  }
}
