import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared/text_styles.dart';

class OTPInputWidget extends StatelessWidget {
  final Function(String)? onSubmit;
  const OTPInputWidget({super.key, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      borderColor: Color(0xFF512DA8),
      showFieldAsBox: true,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      fieldWidth: 50,
      fieldHeight: 60,
      styles: [
        TSB.semiBoldXLarge(),
        TSB.semiBoldXLarge(),
        TSB.semiBoldXLarge(),
        TSB.semiBoldXLarge(),
        TSB.semiBoldXLarge(),
        TSB.semiBoldXLarge(),
      ],
      onSubmit: onSubmit,
    );
  }
}
