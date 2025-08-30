import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/start_rating_view.dart';
import 'package:shared/text_styles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import '../../../data/model/bean/market.dart';
import 'home_viewmodel.dart';
import 'store_distance_widget.dart';

class NearbyStoreView extends ViewModelWidget<HomeViewModel> {
  const NearbyStoreView({super.key});
  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Near by Stores',
          style: TSB.boldXLarge(textColor: black_text_color),
        ),
        SizedBox(height: 15),
        viewModel.busy(viewModel.marketList)
            ? _storeLoadingView()
            : _storeListView(viewModel)
      ],
    );
  }

  _storeLoadingView() {
    return SizedBox(
      child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 10,
          separatorBuilder: (_, i) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[200]!,
              highlightColor: Colors.grey[50]!,
              period: const Duration(milliseconds: 2000),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(color: Colors.grey, width: 100, height: 100),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(color: Colors.grey, width: 200, height: 25),
                        SizedBox(height: 5),
                        Container(color: Colors.grey, width: 150, height: 25),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  _storeListView(HomeViewModel model) {
    if (model.marketList.isEmpty) {
      return SizedBox(
        height: 150,
        child: Center(
          child: Text(
            'No store available',
            style: TSB.regularSmall(),
          ),
        ),
      );
    }
    return SizedBox(
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: model.marketList.length,
        separatorBuilder: (_, i) => SizedBox(height: 10),
        itemBuilder: (context, index) {
          return InkWell(
              child: _buildVerticalList(model.marketList[index], model),
              onTap: () =>
                  model.nearByStoreListItemClick(model.marketList[index]));
        },
      ),
    );
  }

  _buildVerticalList(Market market, HomeViewModel model) {
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
                placeholder: (_, url) => Image.asset(AppImages.defaultImage),
                errorWidget: (context, url, error) =>
                    Image.asset(AppImages.defaultImage),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  StarRatingView(rating: market.rating?.toDouble() ?? 0),
                SizedBox(height: 5),
              ],
            ),
          )
        ],
      ),
    );
  }
}
