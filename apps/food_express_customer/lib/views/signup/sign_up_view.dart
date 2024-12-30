import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/constants.dart';
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
                Text('Sign Up', style: TSB.bold(textSize: 28)),
                SizedBox(height: 5),
                Text(
                  'Please fill in the details below.',
                  style: TSB.semiBoldMedium(textColor: grey_sub_text_color),
                ),
                SizedBox(height: 18),
                Row(
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
                              value: model.selectedCCode,
                              underline: Container(),
                              style: TSB.regularSmall(
                                  textColor: theme_text_hint_color),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: theme_text_hint_color,
                                size: 24,
                              ),
                              onChanged: (val) => model.updateCountryCode(val!),
                              items: countryCodes.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TSB.regularSmall(
                                        textColor: black_text_color),
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
                        focusNode: _mobileNode,
                        onChanged: (String val) => model.mobile = val,
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
                    if (_formKey.currentState?.validate() ?? false) {
                      hideKeyboard(context);
                      model.signUp();
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
