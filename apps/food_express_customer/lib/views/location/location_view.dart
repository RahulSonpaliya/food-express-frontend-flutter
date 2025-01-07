import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:food_express_customer/views/location/location_viewmodel.dart';
import 'package:shared/colors.dart';
import 'package:shared/secrets.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

class LocationView extends StackedView<LocationViewModel> {
  const LocationView({super.key});

  @override
  Widget builder(BuildContext context, LocationViewModel model, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 15),
              TextField(
                style: TSB.regularSmall(),
                readOnly: true,
                enableInteractiveSelection: false,
                onTap: () => openGooglePlaceAutoComplete(model, context),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Search for Area or Street Name...',
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: cart_item_border_color, width: 1.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Get Current Location',
                              style: TSB.regularMedium(),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Using GPS',
                              style: TSB.regularSmall(
                                textColor: grey_hint_text_color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.location_on_outlined),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                child: Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }

  openGooglePlaceAutoComplete(
      LocationViewModel model, BuildContext context) async {
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

  @override
  LocationViewModel viewModelBuilder(BuildContext context) =>
      LocationViewModel();
}
