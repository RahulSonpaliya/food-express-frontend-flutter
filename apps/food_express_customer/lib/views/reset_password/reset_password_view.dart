import 'package:flutter/material.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/common_utils.dart' as common_utils;
import 'package:shared/constants.dart';
import 'package:shared/password_input_widget.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import 'reset_password_viewmodel.dart';

class ResetPasswordView extends StackedView<ResetPasswordViewModel> {
  final String countryCode;
  final String phoneNumber;
  ResetPasswordView({
    super.key,
    required this.countryCode,
    required this.phoneNumber,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget builder(
      BuildContext context, ResetPasswordViewModel model, Widget? child) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Center(
                child: Image.asset(
                  AppImages.foodExpressLogo,
                  height: 250,
                ),
              ),
              Text('Reset Password', style: TSB.bold(textSize: 28)),
              SizedBox(height: 5),
              Text(
                'Enter new password for your FoodExpress account.',
                style: TSB.semiBoldMedium(textColor: grey_sub_text_color),
              ),
              SizedBox(height: 18),
              PasswordInputWidget(
                hintText: 'Password',
                onChanged: (String val) => model.password = val,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 10),
              PasswordInputWidget(
                hintText: 'Confirm Password',
                onChanged: (String val) => model.confirmPassword = val,
                textInputAction: TextInputAction.done,
                validatorFunction: (value) {
                  if (value != model.password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  common_utils.hideKeyboard(context);
                  if (_formKey.currentState?.validate() ?? false) {
                    model.submit();
                  } else {
                    if (model.password.isNotEmpty ||
                        model.confirmPassword.isNotEmpty) {
                      if (!common_utils.isValidPassword(model.password) ||
                          !common_utils
                              .isValidPassword(model.confirmPassword)) {
                        common_utils.showDialog(passwordValidationMessage);
                      }
                    }
                  }
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  ResetPasswordViewModel viewModelBuilder(BuildContext context) =>
      ResetPasswordViewModel(
        countryCode: countryCode,
        phoneNumber: phoneNumber,
      );
}
