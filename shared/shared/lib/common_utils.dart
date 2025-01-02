import 'package:flutter/material.dart';
import 'package:shared/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/dialogs.dart';
import 'data/local/app_shared_prefs.dart';
import 'data/remote/failure.dart';

hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

showLoading() => locator<DialogService>().showCustomDialog(
      variant: DialogType.Loading,
    );

hideLoading() => locator<DialogService>().completeDialog(DialogResponse());

final _dialogService = locator.get<DialogService>();

void handleFailure(failure,
    {dialogTitle,
    okBtnTitle,
    cancelBtnTitle,
    okBtnClick,
    cancelBtnClick}) async {
  String message = "";

  if (failure is TimeoutError) {
    message = "Request Time Out";
  } else if (failure is UnknownError) {
    message =
        "Something went wrong! please check your internet connection & try again.";
  } else if (failure is ServerError) {
    message = failure.message;
    if (failure.statusCode == 401) {
      okBtnTitle = "Logout";
      okBtnClick = () async {
        await AppSharedPrefs.get().clearSharedPreference();
      };
    }
    if (failure.statusCode == 426) {
      okBtnTitle = "Update Now";
      okBtnClick = () async {};
    }
  } else if (failure is NoInternetError) {
    message =
        "Network error: Unable to connect to the server. Please check your internet connection or try again later.";
  }

  showDialog(message,
      dialogTitle: dialogTitle,
      okBtnTitle: okBtnTitle,
      cancelBtnTitle: cancelBtnTitle,
      okBtnClick: okBtnClick,
      cancelBtnClick: cancelBtnClick);
}

showRetryCancelDialog({failure, message, okBtnClick, cancelBtnClick}) {
  if (failure != null) {
    handleFailure(failure,
        okBtnTitle: "Retry",
        okBtnClick: okBtnClick,
        cancelBtnTitle: "Cancel",
        cancelBtnClick: cancelBtnClick);
  } else {
    showDialog(message, okBtnClick: okBtnClick, cancelBtnClick: cancelBtnClick);
  }
}

showRetryDialog({failure, message, okBtnClick}) {
  if (failure != null) {
    handleFailure(failure, okBtnTitle: "Retry", okBtnClick: okBtnClick);
  } else {
    showDialog(message, okBtnClick: okBtnClick);
  }
}

showDialog(String message,
    {dialogTitle,
    okBtnTitle,
    cancelBtnTitle,
    okBtnClick,
    cancelBtnClick}) async {
  var _dialogRes = await _dialogService.showCustomDialog(
      variant: DialogType.Basic,
      title: dialogTitle ?? "Alert",
      mainButtonTitle: okBtnTitle ?? "OK",
      secondaryButtonTitle: cancelBtnTitle,
      description: message);

  if (_dialogRes != null) {
    if (_dialogRes.confirmed) {
      if (okBtnClick != null) {
        okBtnClick();
      }
    } else {
      if (cancelBtnClick != null) {
        cancelBtnClick();
      }
    }
  }
  return _dialogRes;
}
