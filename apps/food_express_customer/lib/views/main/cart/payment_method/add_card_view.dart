import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:shared/colors.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/decoration.dart';
import 'package:shared/masked_textinput_formatter.dart';
import 'package:shared/size_config.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import 'payment_method_viewmodel.dart';

class AddCardView extends ViewModelWidget<PaymentMethodViewModel> {
  @override
  Widget build(BuildContext context, PaymentMethodViewModel model) {
    return Container(
      padding: EdgeInsets.only(
          top: SizeConfig.margin_padding_15,
          left: SizeConfig.margin_padding_15,
          right: SizeConfig.margin_padding_15),
      child: KeyboardActions(
        config: KeyboardActionsConfig(
            keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
            keyboardBarColor: Colors.grey[200],
            nextFocus: false,
            actions: [
              KeyboardActionsItem(
                focusNode: _numNode,
              ),
              KeyboardActionsItem(
                focusNode: _nameNode,
              ),
              KeyboardActionsItem(
                focusNode: _expNode,
              ),
              KeyboardActionsItem(
                focusNode: _cvvNode,
              )
            ]),
        child: Wrap(
          children: <Widget>[
            Container(
              color: cart_item_background_color,
              padding: EdgeInsets.fromLTRB(SizeConfig.margin_padding_24, 0,
                  SizeConfig.margin_padding_24, 0),
              margin: EdgeInsets.only(bottom: SizeConfig.margin_padding_24),
              child: _getCardInputForm(model),
            ),
            Container(
              margin: EdgeInsets.only(bottom: SizeConfig.margin_padding_24),
              child: _buildDoneButton(context, model),
            ),
          ],
        ),
      ),
    );
  }

  FocusNode _numNode = FocusNode();
  FocusNode _nameNode = FocusNode();
  FocusNode _expNode = FocusNode();
  FocusNode _cvvNode = FocusNode();

  _getCardInputForm(PaymentMethodViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.margin_padding_28,
        ),
        Row(
          children: [
            Image.asset('assets/ic_credit_card.png'),
            SizedBox(
              width: SizeConfig.margin_padding_20,
            ),
            Text(
              'Add Card Detail',
              style: TSB.boldSmall(textColor: black_text_color),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.margin_padding_20,
        ),
        Text(
          'Card Number',
          style: TSB.regularSmall(textColor: grey_hint_text_color),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_13,
        ),
        TextField(
          textInputAction: TextInputAction.done,
          style: TSB.regularSmall(textColor: black_text_color),
          onChanged: (s) => model.number = s,
          focusNode: _numNode,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
            MaskedTextInputFormatter(
                mask: 'xxxx xxxx xxxx xxxx', separator: ' ')
          ],
          decoration: textFieldDecorationAddCard.copyWith(
              hintText: '', errorText: model.numError),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_20,
        ),
        Text(
          'Card Holder',
          style: TSB.regularSmall(textColor: grey_hint_text_color),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_13,
        ),
        TextField(
          textInputAction: TextInputAction.done,
          style: TSB.regularSmall(textColor: black_text_color),
          onChanged: (s) => model.name = s,
          focusNode: _nameNode,
          decoration: textFieldDecorationAddCard.copyWith(
            hintText: '',
            errorText: model.nameError,
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiry',
                    style: TSB.regularSmall(textColor: grey_hint_text_color),
                  ),
                  SizedBox(
                    height: SizeConfig.margin_padding_13,
                  ),
                  TextField(
                    textInputAction: TextInputAction.done,
                    style: TSB.regularSmall(textColor: black_text_color),
                    onChanged: (s) => model.expiry = s,
                    focusNode: _expNode,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9/]")),
                      MaskedTextInputFormatter(mask: 'xx/xxxx', separator: '/')
                    ],
                    decoration: textFieldDecorationAddCard.copyWith(
                      hintText: '12/2023',
                      errorText: model.expError,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: SizeConfig.margin_padding_15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CVV',
                    style: TSB.regularSmall(textColor: grey_hint_text_color),
                  ),
                  SizedBox(
                    height: SizeConfig.margin_padding_13,
                  ),
                  TextField(
                    textInputAction: TextInputAction.done,
                    style: TSB.regularSmall(textColor: black_text_color),
                    onChanged: (s) => model.cvv = s,
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    focusNode: _cvvNode,
                    obscureText: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                    ],
                    decoration: textFieldDecorationAddCard.copyWith(
                      hintText: '',
                      counterText: '',
                      errorText: model.cvvError,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.margin_padding_24,
        ),
      ],
    );
  }

  _buildDoneButton(BuildContext context, PaymentMethodViewModel model) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: MaterialButton(
        onPressed: () {
          hideKeyboard(context);
          model.doneClick();
        },
        color: theme_blue_color_1,
        height: SizeConfig.margin_padding_50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Done',
              style: TSB.boldSmall(textColor: Colors.white),
            ),
            SizedBox(
              width: SizeConfig.margin_padding_5,
            ),
            Image.asset('assets/ic_get_started.png')
          ],
        ),
      ),
    );
  }
}
