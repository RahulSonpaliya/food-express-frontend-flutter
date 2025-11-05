import 'package:flutter/material.dart';
import 'package:shared/text_styles.dart';

import 'colors.dart';

var containerDecoration1 = BoxDecoration(
    color: colorWhite,
    borderRadius: BorderRadius.all(Radius.circular(5)),
    border: Border.all(color: colorWhite, width: 0));

var textFieldDecoration1 = InputDecoration(
  border: InputBorder.none,
  counterText: '',
  contentPadding: EdgeInsets.all(10),
);

var textFieldDecoration2 = InputDecoration(
  border: _inputBorder,
  enabledBorder: _inputBorder,
  disabledBorder: _inputBorder,
  errorBorder: _inputBorder,
  focusedBorder: _inputBorder,
  focusedErrorBorder: _inputBorder,
  fillColor: bg_edit_text_color,
  filled: true,
  contentPadding: EdgeInsets.symmetric(horizontal: 15),
  hintStyle: TSB.regularSmall(textColor: grey_hint_text_color),
);

var _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: bg_edit_text_color));

var textFieldDecorationHomeSearch = InputDecoration(
  border: _inputSearchBorder,
  enabledBorder: _inputSearchBorder,
  disabledBorder: _inputSearchBorder,
  errorBorder: _inputSearchBorder,
  focusedBorder: _inputSearchBorder,
  focusedErrorBorder: _inputSearchBorder,
  fillColor: bg_edit_text_color,
  filled: true,
  prefixIcon: Image.asset('assets/ic_search_grocery.png'),
  contentPadding: EdgeInsets.symmetric(horizontal: 15),
  hintStyle: TSB.regularSmall(textColor: grey_hint_text_color),
);

var _inputSearchBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: BorderSide(color: bg_edit_text_color),
);

var textFieldDecorationAmount = InputDecoration(
  border: _inputSearchBorder,
  enabledBorder: _inputSearchBorder,
  disabledBorder: _inputSearchBorder,
  errorBorder: _inputSearchBorder,
  focusedBorder: _inputSearchBorder,
  focusedErrorBorder: _inputSearchBorder,
  fillColor: bg_edit_text_color,
  filled: true,
  prefixIcon: Icon(
    Icons.attach_money,
    color: black_text_color,
  ),
  contentPadding: EdgeInsets.symmetric(horizontal: 15),
  hintStyle: TSB.regularSmall(textColor: grey_hint_text_color),
);

var textFieldDecorationAddCard = InputDecoration(
  border: _inputAddCard,
  enabledBorder: _inputAddCard,
  disabledBorder: _inputAddCard,
  errorBorder: _inputAddCard,
  focusedBorder: _inputAddCard,
  focusedErrorBorder: _inputAddCard,
  contentPadding: EdgeInsets.symmetric(horizontal: 15),
  hintStyle: TSB.regularSmall(textColor: grey_hint_text_color),
);

var _inputAddCard = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
  borderSide: BorderSide(color: cart_item_border_color, width: 1.0),
);
