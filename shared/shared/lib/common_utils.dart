import 'package:flutter/material.dart';

hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
