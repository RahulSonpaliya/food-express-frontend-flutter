import 'package:flutter/material.dart';
import 'package:shared/colors.dart';
import 'package:shared/size_config.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import 'new_my_address_viewmodel.dart';

class MyAddressNewView extends StatefulWidget {
  bool fromCheckOutScreen;

  MyAddressNewView({this.fromCheckOutScreen = false});

  @override
  _MyAddressNewViewState createState() => _MyAddressNewViewState();
}

class _MyAddressNewViewState extends State<MyAddressNewView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyAddressNewViewModel>.reactive(
        builder: (_, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              titleSpacing: 0,
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: model.navigateBack,
                child: Icon(Icons.arrow_back),
              ),
              title: Text(
                'My Address',
                style: TSB.boldMedium(textColor: black_text_color),
              ),
              actions: [
                Container(
                  padding: EdgeInsets.only(
                      right: SizeConfig.margin_padding_15,
                      top: SizeConfig.margin_padding_5),
                  child: GestureDetector(
                    onTap: model.addAddressClick,
                    child: Icon(
                      Icons.add_circle,
                      size: SizeConfig.margin_padding_24,
                      color: blue_button_color,
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: model.loading
                  ? _loadingView()
                  : model.addressList.length > 0
                      ? ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            top: SizeConfig.margin_padding_24,
                            left: SizeConfig.margin_padding_24,
                            right: SizeConfig.margin_padding_24,
                            bottom: SizeConfig.margin_padding_20,
                          ),
                          separatorBuilder: (_, i) => SizedBox(
                            height: SizeConfig.margin_padding_10,
                          ),
                          itemCount: model.addressList.length,
                          itemBuilder: (context, index) => Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Address 1  ${model.addressList[index].addressNickName}',
                                    style: TSB.regularSmall(
                                        textColor: grey_hint_text_color)),
                                SizedBox(
                                  height: SizeConfig.margin_padding_10,
                                ),
                                GestureDetector(
                                  child: Container(
                                    //height: SizeConfig.margin_padding_50,
                                    padding: EdgeInsets.symmetric(
                                        vertical: SizeConfig.margin_padding_10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: cart_item_border_color),
                                        borderRadius: BorderRadius.circular(
                                            SizeConfig.margin_padding_8)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          width: SizeConfig.margin_padding_10,
                                        ),
                                        GestureDetector(
                                          child: model
                                                  .addressList[index].isDefault
                                              ? Image.asset(
                                                  'assets/ic_radio_button.png')
                                              : Image.asset(
                                                  'assets/ic_radio_button01.png'),
                                          onTap: () {
                                            if (widget.fromCheckOutScreen) {
                                              model.onCheckOutBack(
                                                  model.addressList[index]);
                                            } else {
                                              model.setAsDefaultApi(model
                                                  .addressList[index]
                                                  .addressId);
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          width: SizeConfig.margin_padding_10,
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: new SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            //.horizontal
                                            child: Text(
                                              model.addressList[index]
                                                      .address ??
                                                  '45 Trade Centre Dr, Hyde Park,',
                                              style: TSB.regularSmall(),
                                              maxLines: 6,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeConfig.margin_padding_10,
                                        ),
                                        GestureDetector(
                                          child: Image.asset(
                                              'assets/ic_delete.png',
                                              height: 18,
                                              width: 18),
                                          onTap: () {
                                            model.deleteButtonClick(model
                                                .addressList[index].addressId);
                                          },
                                        ),
                                        SizedBox(
                                          width: SizeConfig.margin_padding_10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    if (widget.fromCheckOutScreen) {
                                      model.onCheckOutBack(
                                          model.addressList[index]);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          child: Center(
                            child: Text(
                              'No Address found',
                              style: TSB.regularSmall(),
                            ),
                          ),
                        ),
            ),
          );
        },
        viewModelBuilder: () => MyAddressNewViewModel());
  }
}

_loadingView() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
