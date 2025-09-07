import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_express_customer/views/main/home/store_distance_widget.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/common_utils.dart';
import 'package:shared/start_rating_view.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import '../../../../data/model/bean/category.dart';
import '../../../../data/model/bean/market.dart';
import '../../../../data/model/bean/product.dart';
import 'search_viewmodel.dart';

class SearchView extends StatelessWidget {
  final List<Category> categoryList;

  const SearchView({super.key, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
        builder: (_, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextField(
                      style: TSB.regularSmall(),
                      autofocus: true,
                      onChanged: (String val) => model.searchOnChange.add(val),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Search grocery',
                        suffix: model.busy(model.searchProductList)
                            ? _loadingIndicator()
                            : null,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    _getBody(model),
                  ],
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => SearchViewModel(categoryList: categoryList));
  }

  _getBody(SearchViewModel model) {
    if (model.busy(model.searchProductList) ||
        model.busy(model.userProfileList)) {
      return SizedBox.shrink();
    } else {
      if (model.searchProductList.isEmpty && model.userProfileList.isEmpty) {
        return Center(
          child: Text(
            'Search result not found!!',
            style: TSB.boldMedium(),
          ),
        );
      } else {
        return Column(
          children: [
            _buildProductList(model),
            SizedBox(
              height: 10,
            ),
            _buildMarketList(model),
          ],
        );
      }
    }
  }

  Widget _loadingIndicator() {
    return SizedBox(
      width: 15,
      height: 15,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }

  Widget _buildMarketList(SearchViewModel model) {
    return SizedBox(
      child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: model.userProfileList.length,
          separatorBuilder: (_, i) => SizedBox(
                height: 10,
              ),
          itemBuilder: (context, index) {
            return InkWell(
              child: _buildVerticalList(model.userProfileList[index], model),
              onTap: () {
                hideKeyboard(context);
                model.searchStoreItemClick(model.userProfileList[index]);
              },
            );
          }),
    );
  }

  _buildVerticalList(Market market, SearchViewModel model) {
    return Container(
        alignment: Alignment.topCenter,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: CachedNetworkImage(
                imageUrl: market.image,
                fit: BoxFit.cover,
                placeholder: (_, url) => Image.asset(AppImages.defaultImage),
                errorWidget: (context, url, error) =>
                    Image.asset(AppImages.defaultImage),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 12,
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      market.name,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 2,
                      style: TSB.boldMedium(textColor: black_text_color),
                    ),
                    SizedBox(height: 3),
                    Text(
                      market.address,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 2,
                      style: TSB.regularSmall(textColor: black_text_color),
                    ),
                    SizedBox(height: 3),
                    StoreDistanceWidget(
                      market: market,
                      calculateDistance: model.calculateDistance(market),
                    ),
                    SizedBox(height: 8),
                    if (market.rating != null)
                      SizedBox(
                        width: 50 + 5,
                        child: StarRatingView(
                          rating: market.rating?.toDouble() ?? 0,
                        ),
                      ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  _buildProductList(SearchViewModel model) {
    return SizedBox(
      child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: model.searchProductList.length,
          separatorBuilder: (_, i) {
            return Padding(
              padding: EdgeInsets.only(left: 85 + 15, top: 5, bottom: 10),
              child: Container(
                height: 5,
                color: cart_item_divider_color,
              ),
            );
          },
          itemBuilder: (context, index) => _buildCardListItem(
              context, model.searchProductList[index], model)),
    );
  }

  _buildCardListItem(
    BuildContext context,
    Product p,
    SearchViewModel model,
  ) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          hideKeyboard(context);
          model.searchProductItemClick(p);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: p.image ?? '',
              fit: BoxFit.cover,
              width: 85,
              height: 85,
              placeholder: (_, url) => Image.asset(AppImages.defaultImage),
              errorWidget: (context, url, error) =>
                  Image.asset(AppImages.defaultImage),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.name,
                    style: TSB.semiBoldMedium(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '\$${(p.options?.isEmpty ?? true) ? p.price.toStringAsFixed(2) : p.options![0].price.toStringAsFixed(2)}',
                    style: TSB.semiBoldSmall(textColor: theme_blue_color_1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
