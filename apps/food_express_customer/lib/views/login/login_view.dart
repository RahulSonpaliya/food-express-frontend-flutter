import 'package:flutter/material.dart';
import 'package:food_express_customer/views/login/login_viewmodel.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/mobile_number_input_widget.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StackedView<LogInViewModel> {
  LoginView({super.key, this.fromInside = false});

  final bool fromInside;
  final FocusNode _mobileNode = FocusNode();
  final FocusNode _pwdNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget builder(BuildContext context, LogInViewModel model, Widget? child) {
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
              KeyboardActionsItem(
                focusNode: _pwdNode,
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
                Text('Login', style: TSB.bold(textSize: 28)),
                SizedBox(height: 5),
                Text(
                  'Please login to your account.',
                  style: TSB.semiBoldMedium(textColor: grey_sub_text_color),
                ),
                SizedBox(height: 18),
                MobileNumberInputWidget(
                  selectedCCode: model.selectedCCode,
                  onCountryCodeChanged: (val) => model.updateCountryCode(val!),
                  onMobileNumberChanged: (val) => model.mobile = val,
                  mobileFocusNode: _mobileNode,
                ),
                SizedBox(height: 13),
                TextFormField(
                  style: TSB.regularSmall(),
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  focusNode: _pwdNode,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  onChanged: (String val) => model.password = val,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: model.navigateToForgotPassword,
                    child: Text(
                      "Forgot Password?",
                      style: TSB.semiBoldSmall(textColor: theme_blue_color_1),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      hideKeyboard(context);
                      model.login();
                    }
                  },
                  child: Text('Login'),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      hideKeyboard(context);
                      if (fromInside) {
                        model.navigateBack();
                      } else {
                        model.guestLogin();
                      }
                    },
                    child: Text('Continue as guest'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Don\'t have an account?',
                      style:
                          TSB.semiBoldSmall(textColor: theme_text_hint_color),
                    ),
                    InkWell(
                      onTap: model.navigateToSignUp,
                      child: Text(
                        'Sign Up',
                        style: TSB.semiBoldLarge(textColor: theme_blue_color_1),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  LogInViewModel viewModelBuilder(BuildContext context) => LogInViewModel();
}
