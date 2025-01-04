import 'package:flutter/material.dart';
import 'package:food_express_customer/views/forgot_password/forgot_password_viewmodel.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/mobile_number_input_widget.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StackedView<ForgotPasswordViewModel> {
  ForgotPasswordView({super.key});

  final FocusNode _mobileNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget builder(
      BuildContext context, ForgotPasswordViewModel model, Widget? child) {
    return Scaffold(
      appBar: AppBar(),
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
                Text('Forgot Password', style: TSB.bold(textSize: 28)),
                SizedBox(height: 5),
                Text(
                  'Please enter the registered mobile number. You will receive OTP on the same number',
                  style: TSB.semiBoldMedium(textColor: grey_sub_text_color),
                ),
                SizedBox(height: 18),
                MobileNumberInputWidget(
                  selectedCCode: model.selectedCCode,
                  onCountryCodeChanged: (val) => model.updateCountryCode(val!),
                  onMobileNumberChanged: (val) => model.mobile = val,
                  mobileFocusNode: _mobileNode,
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
      ),
    );
  }

  @override
  ForgotPasswordViewModel viewModelBuilder(BuildContext context) =>
      ForgotPasswordViewModel();
}
