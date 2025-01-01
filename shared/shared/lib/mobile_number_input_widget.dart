import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'constants.dart';
import 'text_styles.dart';

class MobileNumberInputWidget extends StatelessWidget {
  final String selectedCCode;
  final void Function(String?)? onCountryCodeChanged;
  final void Function(String)? onMobileNumberChanged;
  final FocusNode mobileFocusNode;
  const MobileNumberInputWidget(
      {super.key,
      required this.selectedCCode,
      this.onCountryCodeChanged,
      required this.mobileFocusNode,
      this.onMobileNumberChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Material(
            color: bg_edit_text_color,
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(5),
              child: Container(
                alignment: Alignment.center,
                child: DropdownButton(
                  value: selectedCCode,
                  underline: Container(),
                  style: TSB.regularSmall(textColor: theme_text_hint_color),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: theme_text_hint_color,
                    size: 24,
                  ),
                  onChanged: onCountryCodeChanged,
                  items: countryCodes.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TSB.regularSmall(textColor: black_text_color),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          flex: 9,
          child: TextFormField(
            style: TSB.regularSmall(),
            focusNode: mobileFocusNode,
            onChanged: onMobileNumberChanged,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            ],
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Mobile number is required';
              }
              return null;
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Mobile number',
              counterText: '',
            ),
            maxLength: 10,
          ),
        ),
      ],
    );
  }
}
