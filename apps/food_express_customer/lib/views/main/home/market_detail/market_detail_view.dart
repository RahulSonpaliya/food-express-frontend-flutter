import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_express_customer/views/main/home/store_distance_widget.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/start_rating_view.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import '../../../../data/model/bean/category.dart';
import '../../../../data/model/bean/market.dart';
import '../../../../data/model/bean/order.dart';
import 'market_detail_viewmodel.dart';
import 'product_list_view/product_list_view.dart';

class MarketDetailView extends StatelessWidget {
  final Market market;
  final List<Category> categoryList;
  const MarketDetailView({
    super.key,
    required this.market,
    required this.categoryList,
  });
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MarketDetailViewModel>.reactive(
        builder: (_, model, child) {
          return Scaffold(
              bottomSheet: ValueListenableBuilder(
                valueListenable: appOrderFromServer,
                builder: (_, order, child) {
                  return Visibility(
                    visible: (appOrderFromServer.value != null &&
                        appOrderFromServer.value!.carts.isNotEmpty),
                    child: Container(
                      color: theme_blue_color_1,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '\$${order?.total?.toStringAsFixed(2) ?? ''}',
                                style:
                                    TSB.semiBoldLarge(textColor: Colors.white),
                              ),
                              Container(
                                width: 1,
                                height: 29,
                                margin: EdgeInsets.only(left: 5, right: 5),
                                color: Colors.white,
                              ),
                              Text(
                                _getItemsCount(order),
                                style:
                                    TSB.regularMedium(textColor: Colors.white),
                              ),
                            ],
                          ),
                          MaterialButton(
                            onPressed: model.showViewCartBtn,
                            elevation: 0,
                            color: theme_blue_color_1,
                            disabledColor: Colors.grey,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'View Cart',
                                  style: TSB.semiBoldSmall(
                                      textColor: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                // Image.asset('assets/ic_get_started.png')
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              body: DefaultTabController(
                  length: categoryList.length,
                  child: NestedScrollView(
                      headerSliverBuilder: (_, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            expandedHeight: 100 * 2,
                            pinned: true,
                            backgroundColor: Colors.grey[200],
                            leading: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: model.navigateBack),
                            flexibleSpace: FlexibleSpaceBar(
                              //title: Text(market.name, style: TSB.semiBoldMedium(),),
                              background: CachedNetworkImage(
                                imageUrl: market.image,
                                fit: BoxFit.cover,
                                placeholder: (_, url) => Image.asset(
                                  AppImages.defaultImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SliverPrototypeExtentList(
                              delegate:
                                  SliverChildListDelegate([_content(model)]),
                              prototypeItem: _content(model)),
                          SliverPersistentHeader(
                            delegate: _SliverAppBarDelegate(
                              TabBar(
                                labelStyle: TSB.semiBoldMedium(),
                                unselectedLabelStyle: TSB.semiBoldSmall(),
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorColor: theme_blue_color_1,
                                isScrollable: true,
                                labelColor: theme_text_fill_color,
                                unselectedLabelColor: theme_text_hint_color,
                                tabs: categoryList
                                    .map((e) => Tab(text: e.name))
                                    .toList(),
                              ),
                            ),
                            pinned: true,
                          ),
                        ];
                      },
                      body: TabBarView(
                        children: categoryList
                            .map((e) => Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: ProductListView(
                                    market: market,
                                    category: e,
                                    onTapProduct: (p) => model
                                        .navigateToProductDetail(market, p),
                                  ),
                                ))
                            .toList(),
                      ))));
        },
        viewModelBuilder: () => MarketDetailViewModel(market));
  }

  _getItemsCount(Order? order) {
    if (order != null && order.carts.isNotEmpty) {
      return '${order.carts.length} ${order.carts.length > 1 ? 'Items' : 'Item'}';
    }
    return '';
  }

  _content(MarketDetailViewModel model) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28), topRight: Radius.circular(28)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      market.name,
                      style: TSB.boldMedium(),
                      maxLines: 2,
                    )),
                    if (market.rating != null)
                      StarRatingView(rating: market.rating?.toDouble() ?? 0),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      market.address,
                      style: TSB.semiBoldSmall(),
                      maxLines: 2,
                    )),
                    Text(
                      '',
                      style: TSB.semiBoldSmall(textColor: theme_blue_color_1),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                StoreDistanceWidget(
                  market: market,
                  calculateDistance: model.calculateDistance(market),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.grey[100],
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
