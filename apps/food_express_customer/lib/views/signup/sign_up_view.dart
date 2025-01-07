import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/common_utils.dart' as common_utils;
import 'package:shared/constants.dart';
import 'package:shared/mobile_number_input_widget.dart';
import 'package:shared/password_input_widget.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import 'sign_up_viewmodel.dart';

class SignUpView extends StackedView<SignUpViewModel> {
  SignUpView({super.key});

  final FocusNode _mobileNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget builder(BuildContext context, SignUpViewModel model, Widget? child) {
    return Scaffold(
      body: KeyboardActions(
        config: KeyboardActionsConfig(
            keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
            keyboardBarColor: Colors.grey[200],
            nextFocus: false,
            actions: [
              KeyboardActionsItem(
                focusNode: _mobileNode,
              ),
            ]),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
                Text('Sign Up', style: TSB.bold(textSize: 28)),
                SizedBox(height: 5),
                Text(
                  'Please fill in the details below.',
                  style: TSB.semiBoldMedium(textColor: grey_sub_text_color),
                ),
                SizedBox(height: 18),
                MobileNumberInputWidget(
                  selectedCCode: model.selectedCCode,
                  onCountryCodeChanged: (val) => model.updateCountryCode(val!),
                  onMobileNumberChanged: (val) => model.mobile = val,
                  mobileFocusNode: _mobileNode,
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TSB.regularSmall(),
                  textInputAction: TextInputAction.next,
                  onChanged: (String val) => model.name = val.trim(),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: TSB.regularSmall(),
                  textInputAction: TextInputAction.next,
                  onChanged: (String val) => model.email = val.trim(),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Email Address is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Email Address'),
                ),
                SizedBox(height: 10),
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
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                          value: model.agree,
                          activeColor: theme_blue_color_1,
                          onChanged: model.updateAgreeToTerms),
                    ),
                    SizedBox(width: 15),
                    Flexible(
                      child: Wrap(
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: <Widget>[
                          Text('Agree with our ',
                              style: TSB.regularSmall(
                                  textColor: grey_hint_text_color)),
                          InkWell(
                            onTap: model.navigateToTerms,
                            child: Text('Terms & Conditions',
                                style: TSB.regularMedium(
                                    textColor: theme_blue_color_1)),
                          ),
                          Text(' and ',
                              style: TSB.regularSmall(
                                  textColor: grey_hint_text_color)),
                          InkWell(
                            onTap: model.navigateToPrivacy,
                            child: Text('Privacy Policy',
                                style: TSB.regularMedium(
                                    textColor: theme_blue_color_1)),
                          ),
                          Text('.',
                              style: TSB.regularSmall(
                                  textColor: grey_hint_text_color)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    common_utils.hideKeyboard(context);
                    if (_formKey.currentState?.validate() ?? false) {
                      model.signUp();
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
                  child: Text('Signup'),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'I already have an account.',
                      style: TSB.semiBoldSmall(textColor: grey_hint_text_color),
                    ),
                    InkWell(
                      onTap: model.navigateToLogin,
                      child: Text(
                        'Log In',
                        style: TSB.semiBoldLarge(textColor: theme_blue_color_1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  SignUpViewModel viewModelBuilder(BuildContext context) => SignUpViewModel();
}
