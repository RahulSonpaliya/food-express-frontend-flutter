import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

class PlusMinusBtn extends StatelessWidget {
  bool showMinus;
  var plusClick, minusClick;
  String qty;
  PlusMinusBtn(
      {this.showMinus = false, this.plusClick, this.minusClick, this.qty = ''});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          child: _button(icon: Icons.remove, onTap: minusClick),
          visible: showMinus,
        ),
        Visibility(
          visible: showMinus,
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              qty,
              style: TSB.semiBoldVSmall(),
            ),
          ),
        ),
        _button(icon: Icons.add, onTap: plusClick),
      ],
    );
  }

  _button({icon, onTap}) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: theme_blue_color_1.withOpacity(0.2),
              borderRadius: BorderRadius.circular(3)),
          child: Icon(
            icon,
            color: theme_blue_color_1,
            size: 18,
          ),
        ),
      ),
    );
  }
}
