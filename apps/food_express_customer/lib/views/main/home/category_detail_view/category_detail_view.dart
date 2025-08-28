import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/start_rating_view.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import '../../../../data/model/bean/category.dart';
import '../../../../data/model/bean/market.dart';
import '../../../../data/remote/repository.dart';
import 'category_detail_viewmodel.dart';

class CategoryDetailView extends StatelessWidget {
  final List<Category> categoryList;
  final Category category;

  const CategoryDetailView(
      {super.key, required this.categoryList, required this.category});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryDetailViewModel>.reactive(
        builder: (_, model, child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  backgroundColor: theme_blue_color_1,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: model.navigateBack,
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      category.name,
                      style: TSB.semiBoldMedium(textColor: Colors.white),
                    ),
                    background: CachedNetworkImage(
                      imageUrl: CATEGORY_ICON_URL + category.image,
                      fit: BoxFit.cover,
                      placeholder: (_, url) => Image.asset(
                        AppImages.defaultImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                model.busy(model.marketList)
                    ? _loadingView()
                    : model.marketList.isEmpty
                        ? _noData()
                        : _marketListView(model)
              ],
            ),
          );
        },
        viewModelBuilder: () =>
            CategoryDetailViewModel(category, categoryList));
  }

  _noData() {
    return SliverFillRemaining(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              category.name,
              style: TSB.boldXLarge(),
            ),
            Expanded(
                child: Center(
              child: Text('Markets not found'),
            ))
          ],
        ),
      ),
    );
  }

  _loadingView() {
    return SliverFillRemaining(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              category.name,
              style: TSB.boldXLarge(),
            ),
            Expanded(
                child: Center(
              child: CircularProgressIndicator(),
            ))
          ],
        ),
      ),
    );
  }

  _marketListView(CategoryDetailViewModel model) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: colorWhite),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child:
              model.busy(model.marketList) ? _loadingView() : _content(model),
        ),
      ]),
    );
  }

  _content(CategoryDetailViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.name,
          style: TSB.boldXLarge(),
        ),
        _storeListView(model)
      ],
    );
  }

  _storeListView(CategoryDetailViewModel model) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: model.marketList.length,
      separatorBuilder: (_, i) => SizedBox(
        height: 15,
      ),
      itemBuilder: (context, index) {
        return Material(
          color: colorWhite,
          child: InkWell(
            child: _buildVerticalList(model.marketList[index]),
            onTap: () =>
                model.nearByStoreListItemClick(model.marketList[index]),
          ),
        );
      },
    );
  }

  _buildVerticalList(Market market) {
    return Container(
      alignment: Alignment.topCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: SizedBox(
              width: 100,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: market.image,
                fit: BoxFit.cover,
                placeholder: (_, url) => Image.asset(
                  AppImages.defaultImage,
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) =>
                    Image.asset(AppImages.defaultImage),
              ),
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
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    market.address,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 2,
                    style: TSB.regularSmall(textColor: black_text_color),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  // TODO add distance
                  // Text(
                  //   '${market?.distanceInMiles ?? ''}',
                  //   style: TSB.semiBoldSmall(textColor: black_text_color),
                  // ),
                  SizedBox(
                    height: 8,
                  ),
                  if (market.rating != null)
                    SizedBox(
                      width: 60,
                      child: StarRatingView(
                        rating: market.rating?.toDouble() ?? 0,
                      ),
                    ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
