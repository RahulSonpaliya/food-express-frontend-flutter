import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:shared/app_bar.dart';
import 'package:shared/colors.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/decoration.dart';
import 'package:shared/secrets.dart';
import 'package:shared/size_config.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import 'add_new_address_viewmodel.dart';

class AddNewAddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNewAddressViewModel>.reactive(
        builder: (_, model, child) {
          return Scaffold(
            appBar: getAppBar('Add New Address',
                showBack: true, onBackPressed: model.navigateBack),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.margin_padding_15,
                  ),
                  Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.all(SizeConfig.margin_padding_15),
                      title: _getGPSView(model),
                      trailing: Material(
                        child: InkWell(
                          child: Image.asset('assets/ic_location01.png'),
                          onTap: model.checkLocationPermission3,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.margin_padding_15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.margin_padding_10,
                        ),
                        _address1(model),
                        SizedBox(
                          height: SizeConfig.margin_padding_15,
                        ),
                        _address2(model),
                        SizedBox(
                          height: SizeConfig.margin_padding_15,
                        ),
                        _state(model),
                        SizedBox(
                          height: SizeConfig.margin_padding_15,
                        ),
                        _country(model),
                        SizedBox(
                          height: SizeConfig.margin_padding_15,
                        ),
                        _nickName(model),
                        SizedBox(
                          height: SizeConfig.margin_padding_40,
                        ),
                        MaterialButton(
                          onPressed: () {
                            hideKeyboard(context);
                            model.saveButtonClick();
                          },
                          color: theme_blue_color_1,
                          height: SizeConfig.margin_padding_50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Save',
                                style:
                                    TSB.semiBoldSmall(textColor: Colors.white),
                              ),
                              SizedBox(
                                width: SizeConfig.margin_padding_5,
                              ),
                              Image.asset('assets/ic_get_started.png')
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          );
        },
        viewModelBuilder: () => AddNewAddressViewModel());
  }

  _getGPSView(AddNewAddressViewModel model) {
    if (model.address1 == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Get Current Location',
              style: TSB.semiBoldMedium(textColor: grey_hint_text_color)),
          SizedBox(
            height: SizeConfig.margin_padding_5,
          ),
          Text('Using GPS',
              style: TSB.semiBoldMedium(textColor: grey_hint_text_color)),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.nickName ?? '',
            style: TSB.semiBoldMedium(textColor: grey_hint_text_color)),
        SizedBox(
          height: SizeConfig.margin_padding_5,
        ),
        Text(model.address1 ?? '', style: TSB.regularSmall()),
      ],
    );
  }

  _address1(AddNewAddressViewModel model) {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address 1',
                style: TSB.regularSmall(textColor: grey_hint_text_color)),
            SizedBox(
              height: SizeConfig.margin_padding_8,
            ),
            TextField(
              readOnly: true,
              showCursor: false,
              controller: TextEditingController(text: model.address1),
              onTap: () {
                hideKeyboard(context);
                openGooglePlaceAutoComplete(model, context);
              },
              style: TSB.regularSmall(),
              decoration: textFieldDecorationAddCard.copyWith(
                hintText: 'Address',
                contentPadding: EdgeInsets.all(SizeConfig.margin_padding_10),
                suffixIcon: Image.asset('assets/ic_search_grocery.png'),
              ),
            ),
          ],
        );
      },
    );
  }

  _address2(AddNewAddressViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Address 2',
            style: TSB.regularSmall(textColor: grey_hint_text_color)),
        SizedBox(
          height: SizeConfig.margin_padding_8,
        ),
        TextField(
          style: TSB.regularSmall(),
          onChanged: (val) => model.address2 = val,
          decoration: textFieldDecorationAddCard.copyWith(
            hintText: 'Address',
            contentPadding: EdgeInsets.all(SizeConfig.margin_padding_10),
          ),
        ),
      ],
    );
  }

  _state(AddNewAddressViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('State', style: TSB.regularSmall(textColor: grey_hint_text_color)),
        SizedBox(
          height: SizeConfig.margin_padding_8,
        ),
        AbsorbPointer(
          absorbing: model.stateFound,
          child: TextField(
            style: TSB.regularSmall(),
            controller: TextEditingController(text: model.state),
            onChanged: (val) => model.state = val,
            decoration: textFieldDecorationAddCard.copyWith(
              hintText: 'State',
              contentPadding: EdgeInsets.all(SizeConfig.margin_padding_10),
            ),
          ),
        ),
      ],
    );
  }

  _country(AddNewAddressViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Country',
            style: TSB.regularSmall(textColor: grey_hint_text_color)),
        SizedBox(
          height: SizeConfig.margin_padding_8,
        ),
        AbsorbPointer(
          absorbing: model.countryFound,
          child: TextField(
            style: TSB.regularSmall(),
            controller: TextEditingController(text: model.country),
            onChanged: (val) => model.country = val,
            decoration: textFieldDecorationAddCard.copyWith(
              hintText: 'Country',
              contentPadding: EdgeInsets.all(SizeConfig.margin_padding_10),
            ),
          ),
        ),
      ],
    );
  }

  _nickName(AddNewAddressViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nickname Of Your Address',
            style: TSB.regularSmall(textColor: grey_hint_text_color)),
        SizedBox(
          height: SizeConfig.margin_padding_8,
        ),
        Row(
          children: [
            _nickNameButton('Home', model),
            SizedBox(
              width: SizeConfig.margin_padding_10,
            ),
            _nickNameButton('Office', model),
            SizedBox(
              width: SizeConfig.margin_padding_10,
            ),
            _nickNameButton('Others', model),
          ],
        )
      ],
    );
  }

  _nickNameButton(String title, AddNewAddressViewModel model) {
    bool isSelected = model.nickName == title;
    return Container(
      height: SizeConfig.margin_padding_40 + SizeConfig.margin_padding_5,
      width: SizeConfig.margin_padding_70 + SizeConfig.margin_padding_5,
      color: isSelected ? colorBlack : colorWhite,
      child: Builder(
        builder: (context) {
          return OutlinedButton(
            onPressed: () {
              hideKeyboard(context);
              model.updateNickName(title);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: isSelected ? Colors.black : Colors.grey[300]!,
              ),
              backgroundColor: isSelected ? colorBlack : Colors.grey[300],
            ),
            child: Text(
              title,
              style: TSB.semiBoldVSmall(
                  textColor: isSelected ? colorWhite : theme_text_hint_color),
            ),
          );
        },
      ),
    );
  }

  openGooglePlaceAutoComplete(
      AddNewAddressViewModel model, BuildContext context) async {
    Prediction? prediction = await PlacesAutocomplete.show(
      context: context,
      apiKey: Google_API_KEY,
      mode: Mode.fullscreen,
      language: "en",
      components: [Component(Component.country, 'in')],
      resultTextStyle: TSB.regularMedium(),
    );
    if (prediction != null) {
      model.getPlaceDetails(prediction);
    }
  }
}
