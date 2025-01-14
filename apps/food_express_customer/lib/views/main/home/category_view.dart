import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_express_customer/views/main/home/home_viewmodel.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/text_styles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import '../../../data/remote/repository.dart';

class CategoryView extends ViewModelWidget<HomeViewModel> {
  const CategoryView({super.key});
  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Category',
              style: TSB.boldXLarge(
                textColor: black_text_color,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text('View All'),
            ),
          ],
        ),
        viewModel.busy(viewModel.categoryList)
            ? _catLoadingView()
            : _catListView(viewModel)
      ],
    );
  }

  _catLoadingView() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => SizedBox(
          width: 120,
          child: Column(
            children: <Widget>[
              Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[50]!,
                period: const Duration(milliseconds: 2000),
                child: Container(
                  margin: EdgeInsets.all(13),
                  height: 70,
                  width: 70,
                  color: edit_text_bg_color,
                  child: Center(
                    child: Icon(
                      Icons.category_outlined,
                      color: theme_blue_color_1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _catListView(HomeViewModel model) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: model.categoryList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => model.onCategoryClick(model.categoryList[index]),
          child: SizedBox(
            width: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(13),
                  height: 70,
                  width: 70,
                  color: edit_text_bg_color,
                  child: model.categoryList[index].id != -1
                      ? Center(
                          child: CachedNetworkImage(
                            imageUrl: CATEGORY_ICON_URL +
                                model.categoryList[index].image,
                            height: 40,
                            width: 40,
                            color: theme_blue_color_1,
                            placeholder: (_, url) => Image.asset(
                              AppImages.defaultImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.category_outlined,
                          size: 32,
                          color: theme_blue_color_1,
                        ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      model.categoryList[index].name,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TSB.regularSmall(
                        textColor: grey_category_text_color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
