import 'package:flutter/material.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/otp_input_widget.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import 'otp_verification_viewmodel.dart';

class OtpVerificationView extends StackedView<OtpVerificationViewModel> {
  final String countryCode, mobileNum;
  const OtpVerificationView({
    super.key,
    required this.countryCode,
    required this.mobileNum,
  });

  @override
  Widget builder(
      BuildContext context, OtpVerificationViewModel model, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(height: 40),
            Center(
              child: Image.asset(
                AppImages.foodExpressLogo,
                height: 250,
              ),
            ),
            Text('OTP verification', style: TSB.bold(textSize: 28)),
            SizedBox(height: 10),
            Text(
              'Enter the verification code we have just sent you on your mobile number',
              style: TSB.semiBoldMedium(textColor: grey_sub_text_color),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text(
                  '$countryCode $mobileNum',
                  style: TSB.semiBoldMedium(textColor: black_text_color),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: model.navigateBack,
                  child: Text(
                    'Change',
                    style: TSB.regularMedium(textColor: theme_blue_color_1),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            OTPInputWidget(onSubmit: (value) => model.otp = value),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                // onTap: model.resendOtpApi,
                child: Text(
                  'Resend OTP',
                  style: TSB.semiBoldMedium(textColor: theme_blue_color_1),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Verify',
                style: TSB.semiBoldSmall(textColor: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  OtpVerificationViewModel viewModelBuilder(BuildContext context) =>
      OtpVerificationViewModel(countryCode: countryCode, mobileNum: mobileNum);
}
