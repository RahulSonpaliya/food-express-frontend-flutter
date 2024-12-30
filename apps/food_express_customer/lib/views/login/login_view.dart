import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_express_customer/views/login/login_viewmodel.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/constants.dart';
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
//
// class LogInViewNew extends StatefulWidget {
//   final bool fromInside;
//
//   const LogInViewNew({super.key, this.fromInside = false});
//
//   @override
//   _LogInViewNewState createState() => _LogInViewNewState();
// }
//
// class _LogInViewNewState extends State<LogInViewNew> {
//   final FocusNode _mobileNode = FocusNode();
//   final FocusNode _pwdNode = FocusNode();
//
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<LogInViewModel>.reactive(
//         builder: (_, model, child) {
//           return Scaffold(
//             backgroundColor: Colors.white,
//             body: KeyboardActions(
//               config: KeyboardActionsConfig(
//                   keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
//                   keyboardBarColor: Colors.grey[200],
//                   nextFocus: false,
//                   actions: [
//                     KeyboardActionsItem(
//                       focusNode: _mobileNode,
//                     ),
//                     KeyboardActionsItem(
//                       focusNode: _pwdNode,
//                     ),
//                   ]),
//               child: Container(
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         alignment: const Alignment(0.0, 1.1),
//                         colorFilter: _keyboardVisible
//                             ? const ColorFilter.mode(
//                                 Colors.white, BlendMode.clear)
//                             : null,
//                         image: const AssetImage('assets/bg_signup.png'))),
//                 child: SingleChildScrollView(
//                   child: Wrap(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(
//                             top: SizeConfig.margin_padding_50,
//                             left: SizeConfig.margin_padding_35,
//                             right: SizeConfig.margin_padding_35),
//                         child: _getLoginInputForm(model),
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(
//                             left: SizeConfig.margin_padding_35,
//                             right: SizeConfig.margin_padding_35),
//                         margin: EdgeInsets.only(
//                             bottom: SizeConfig.margin_padding_15),
//                         child: _buildLogInButton(context, model),
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(
//                             left: SizeConfig.margin_padding_35,
//                             right: SizeConfig.margin_padding_35),
//                         margin: EdgeInsets.only(
//                             bottom: SizeConfig.margin_padding_29),
//                         child: _buildGuestButton(context, model),
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(
//                             left: SizeConfig.margin_padding_35,
//                             right: SizeConfig.margin_padding_35),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text(
//                               'Don\'t have an account?',
//                               style: TSB.semiBoldSmall(
//                                   textColor: theme_text_hint_color),
//                             ),
//                             InkWell(
//                               onTap: model.navigateToSignUp,
//                               child: Text(
//                                 'Sign Up',
//                                 style: TSB.semiBoldLarge(
//                                     textColor: theme_blue_color_1),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
// //                      Container(
// //                        padding: EdgeInsets.only(
// //                            left: SizeConfig.margin_padding_35,
// //                            right: SizeConfig.margin_padding_35),
// //                        child: Image.asset('assets/bg_signup.png'),
// //                      )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//         viewModelBuilder: () => LogInViewModel());
//   }
//
//   _getLoginInputForm(LogInViewModel model) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           height: SizeConfig.margin_padding_40,
//         ),
//         Text(
//           'Login',
//           style: TSB.bold(textSize: SizeConfig.margin_padding_28),
//         ),
//         SizedBox(
//           height: SizeConfig.margin_padding_13,
//         ),
//         Text(
//           'Please login to your account.',
//           style: TSB.semiBoldMedium(textColor: grey_sub_text_color),
//         ),
//         SizedBox(
//           height: SizeConfig.margin_padding_18,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               flex: 3,
//               child: Material(
//                 color: bg_edit_text_color,
//                 borderRadius: BorderRadius.circular(5),
//                 child: InkWell(
//                   onTap: () {},
//                   borderRadius: BorderRadius.circular(5),
//                   child: Container(
//                     alignment: Alignment.center,
//                     child: DropdownButton(
//                       value: model.selectedCCode,
//                       underline: Container(),
//                       style: TSB.regularSmall(textColor: theme_text_hint_color),
//                       icon: Icon(
//                         Icons.keyboard_arrow_down,
//                         color: theme_text_hint_color,
//                         size: SizeConfig.margin_padding_24,
//                       ),
//                       onChanged: (val) => model.updateCountryCode(val!),
//                       items: countryCodes.map((e) {
//                         return DropdownMenuItem(
//                           value: e,
//                           child: Text(
//                             e,
//                             style:
//                                 TSB.regularSmall(textColor: black_text_color),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: SizeConfig.margin_padding_15,
//             ),
//             Expanded(
//               flex: 9,
//               child: TextField(
//                 style: TSB.regularSmall(),
//                 focusNode: _mobileNode,
//                 onChanged: (String val) => model.mobile = val,
//                 controller: model.phoneController,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.allow(RegExp("[0-9]")),
//                 ],
//                 textInputAction: TextInputAction.done,
//                 keyboardType: TextInputType.phone,
//                 decoration: textFieldDecoration2.copyWith(
//                     hintText: 'Mobile number', counterText: ''),
//                 maxLength: 10,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: SizeConfig.margin_padding_13,
//         ),
//         TextField(
//           style: TSB.regularSmall(),
//           textInputAction: TextInputAction.done,
//           obscureText: true,
//           focusNode: _pwdNode,
//           onChanged: (String val) => model.password = val,
//           controller: model.passwordController,
//           decoration: textFieldDecoration2.copyWith(
//             hintText: 'Password',
//           ),
//         ),
//         SizedBox(
//           height: SizeConfig.margin_padding_15,
//         ),
//         Align(
//           alignment: Alignment.topRight,
//           child: InkWell(
//             onTap: model.navigateToForgotPassword,
//             child: Container(
//               child: Text(
//                 "Forgot Password?",
//                 style: TSB.semiBoldSmall(textColor: theme_blue_color_1),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: SizeConfig.margin_padding_24,
//         ),
//       ],
//     );
//   }
//
//   _buildLogInButton(BuildContext context, model) {
//     return MaterialButton(
//       onPressed: () {
//         hideKeyboard(context);
//         model.login();
//       },
//       color: theme_blue_color_1,
//       height: SizeConfig.margin_padding_50,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Log In',
//             style: TSB.semiBoldSmall(textColor: Colors.white),
//           ),
//           SizedBox(
//             width: SizeConfig.margin_padding_5,
//           ),
//         ],
//       ),
//     );
//   }
//
//   _buildGuestButton(BuildContext context, LogInViewModel model) {
//     return Center(
//       child: InkWell(
//         onTap: () {
//           hideKeyboard(context);
//           if (widget.fromInside) {
//             model.navigateBack();
//           } else {
//             model.guestLogin();
//           }
//         },
//         child: Text(
//           'Continue as guest',
//           style: TSB.regularSmall(underLineText: true),
//         ),
//       ),
//     );
//   }
// }
