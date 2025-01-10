import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_express_customer/views/main/home/nearby_store_view.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import '../../../data/model/bean/user.dart';
import 'category_view.dart';
import 'home_viewmodel.dart';
import 'user_location_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (_, model, child) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () => model.refreshScreen(),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          flex: 12,
                          child: const UserLocationView(),
                        ),
                        SizedBox(width: 5),
                        appUser.value != null
                            ? Expanded(
                                flex: 2,
                                child: ValueListenableBuilder(
                                  valueListenable: appUser,
                                  builder: (_, user, child) {
                                    return CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: appUser.value!.profileImage,
                                      width: 28,
                                      height: 28,
                                      placeholder:
                                          (BuildContext context, String url) =>
                                              Image.asset(
                                        AppImages.defaultImage,
                                        width: 28,
                                        height: 28,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          flex: 9,
                          child: TextField(
                            showCursor: true,
                            readOnly: true,
                            style: TSB.regularSmall(),
                            textInputAction: TextInputAction.search,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Search grocery',
                            ),
                            onTap: model.searchClick,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 2,
                          child: Material(
                            color: bg_edit_text_color,
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              onTap: () {
                                // TODO: implement
                              },
                              borderRadius: BorderRadius.circular(5),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.filter_alt_outlined,
                                  color: theme_blue_color_1,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CategoryView(),
                    NearbyStoreView(),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
