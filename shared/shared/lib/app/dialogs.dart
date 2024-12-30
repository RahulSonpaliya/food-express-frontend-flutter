import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../colors.dart';
import '../text_styles.dart';
import 'locator.dart';

enum DialogType { Basic, Loading }

void setupDialogUi() {
  var dialogService = locator<DialogService>();
  final builders = {
    DialogType.Loading: (context, sheetRequest, completer) =>
        _LoadingIndicatorDialog(),
    DialogType.Basic: (context, sheetRequest, completer) => _BasicCustomDialog(
          dialogRequest: sheetRequest,
          onDialogTap: completer,
        ),
  };
  dialogService.registerCustomDialogBuilders(builders);
}

class _BasicCustomDialog extends StatelessWidget {
  final DialogRequest dialogRequest;
  final Function(DialogResponse) onDialogTap;

  const _BasicCustomDialog({
    required this.dialogRequest,
    required this.onDialogTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonWidget = ElevatedButton(
      onPressed: () => onDialogTap(DialogResponse(confirmed: true)),
      child: Text(
        dialogRequest.mainButtonTitle ?? '',
        style: TSB.regularVSmall(),
      ),
    );
    if (dialogRequest.secondaryButtonTitle != null) {
      buttonWidget = Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 5),
              child: ElevatedButton(
                onPressed: () => onDialogTap(DialogResponse(confirmed: false)),
                child: Text(
                  dialogRequest.secondaryButtonTitle ?? '',
                  style: TSB.regularVSmall(),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 5, right: 15),
              child: ElevatedButton(
                onPressed: () => onDialogTap(DialogResponse(confirmed: true)),
                child: Text(
                  dialogRequest.mainButtonTitle ?? '',
                  style: TSB.regularVSmall(),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: colorWhite,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              dialogRequest.title != null
                  ? Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        dialogRequest.title!,
                        style: TSB.regularMedium(),
                      ),
                    )
                  : const SizedBox.shrink(),
              Text(
                dialogRequest.description!,
                style: TSB.regularMedium(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              buttonWidget
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingIndicatorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Container(
        color: Colors.white10,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            color: colorWhite,
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
