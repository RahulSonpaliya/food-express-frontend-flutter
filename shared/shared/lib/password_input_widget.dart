import 'package:flutter/material.dart';

import 'common_utils.dart';
import 'text_styles.dart';

class PasswordInputWidget extends StatefulWidget {
  final void Function(String)? onChanged;
  final String hintText;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validatorFunction;
  const PasswordInputWidget({
    super.key,
    this.onChanged,
    required this.hintText,
    this.textInputAction,
    this.validatorFunction,
  });

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TSB.regularSmall(),
      textInputAction: widget.textInputAction,
      obscureText: _isObscured,
      onChanged: widget.onChanged,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return '${widget.hintText} is required';
        }
        if (!isValidPassword(value!)) {
          return 'Enter valid password';
        }
        if (widget.validatorFunction != null) {
          return widget.validatorFunction!(value);
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured; // Toggle text visibility
            });
          },
        ),
      ),
    );
  }
}
