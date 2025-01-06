import 'package:flutter/material.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/common_utils.dart';
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
              TextFormField(
                style: TSB.regularSmall(),
                textInputAction: TextInputAction.next,
                obscureText: true,
                onChanged: (String val) => model.password = val,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Password is required';
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(height: 10),
              TextFormField(
                style: TSB.regularSmall(),
                textInputAction: TextInputAction.done,
                obscureText: true,
                onChanged: (String val) => model.confirmPassword = val,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Confirm Password is required';
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: 'Confirm Password'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    hideKeyboard(context);
                    model.submit();
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
