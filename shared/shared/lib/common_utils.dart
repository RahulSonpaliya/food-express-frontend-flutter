import 'package:flutter/material.dart';
import 'package:shared/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/dialogs.dart';

hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

showLoading() => locator<DialogService>().showCustomDialog(
      variant: DialogType.Loading,
    );

hideLoading() => locator<DialogService>().completeDialog(DialogResponse());
