import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/plus_minus_btn.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import '../../../data/model/bean/market.dart';
import '../../../data/model/bean/order.dart';
import '../../../data/model/bean/product.dart';
import 'product_detail_viewmodel.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;
  final Market market;

  const ProductDetailView({
    required this.market,
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDetailViewModel>.reactive(
        builder: (_, model, child) {
          return Scaffold(
            body: SafeArea(
              child: model.isBusy
                  ? _productLoadingView(model)
                  : _productDetailView(model),
            ),
          );
        },
        viewModelBuilder: () => ProductDetailViewModel(market, product));
  }

  _productLoadingView(ProductDetailViewModel model) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 100 * 2,
              pinned: true,
              backgroundColor: Colors.grey[100],
              leading: IconButton(
                  icon: Icon(Icons.arrow_back), onPressed: model.navigateBack),
              titleSpacing: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: product.image ?? "",
                  fit: BoxFit.contain,
                  placeholder: (_, url) => Image.asset(AppImages.defaultImage),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: TSB.boldMedium(),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  if (product.options?.isNotEmpty ?? false)
                                    Column(
                                      children: [
                                        Text(
                                          product.options![0].variant_name,
                                          style: TSB.regularSmall(
                                              textColor: theme_text_hint_color),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: TSB.boldSmall(
                                        textColor: theme_blue_color_1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
            SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ],
    );
  }

  _productDetailView(ProductDetailViewModel model) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 100 * 2,
              pinned: true,
              backgroundColor: Colors.grey[100],
              leading: IconButton(
                  icon: Icon(Icons.arrow_back), onPressed: model.navigateBack),
              titleSpacing: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: product.image ?? "",
                  fit: BoxFit.contain,
                  placeholder: (_, url) => Image.asset(AppImages.defaultImage),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.productDetail.name,
                                    style: TSB.boldMedium(),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  if (model.selectedOption != null)
                                    Column(
                                      children: [
                                        Text(
                                          model.selectedOption!.variant_name,
                                          style: TSB.regularSmall(
                                              textColor: theme_text_hint_color),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  Text(
                                    '\$${model.selectedOption == null ? model.productDetail.price.toStringAsFixed(2) : model.selectedOption!.price.toStringAsFixed(2)}',
                                    style: TSB.boldSmall(
                                        textColor: theme_blue_color_1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      PlusMinusBtn(
                        plusClick: () => model.plusClick(),
                        minusClick: () => model.minusClick(),
                        showMinus: model.showMinus(),
                        qty: model.getQty(),
                      )
                      //PlusMinusView(model.market, model.productDetail, model.selectedOption,),
                    ],
                  ),
                  Visibility(
                    visible: model.selectedOption != null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[300],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Select Unit',
                          style: TSB.boldMedium(),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                  horizontal: (model.productDetail.options?.isNotEmpty ?? false)
                      ? 15
                      : 0),
              sliver: SliverToBoxAdapter(
                child: (model.productDetail.options?.isNotEmpty ?? false)
                    ? SizedBox(
                        height: 40 + 5,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, i) {
                              var op = model.productDetail.options![i];
                              var isSelected =
                                  op.id == model.selectedOption?.id;
                              return Container(
                                width: 70 + 10,
                                color: isSelected ? colorBlack : colorWhite,
                                child: OutlinedButton(
                                  onPressed: () =>
                                      model.updateSelectedOption(op),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: isSelected
                                          ? theme_text_fill_color
                                          : Colors.grey[300]!,
                                    ),
                                    foregroundColor: isSelected
                                        ? colorWhite
                                        : theme_text_hint_color,
                                    backgroundColor:
                                        isSelected ? colorBlack : null,
                                  ),
                                  child: Text(
                                    op.variant_name,
                                    style: isSelected
                                        ? TSB.semiBoldVSmall(
                                            textColor: colorWhite)
                                        : TSB.semiBoldVSmall(
                                            textColor: theme_text_hint_color),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, i) => SizedBox(
                                  width: 10,
                                ),
                            itemCount: model.productDetail.options!.length),
                      )
                    : SizedBox.shrink(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 10 + (50 + 10 + 10)),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: 10),
                  Container(
                    height: 1,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Description',
                    style: TSB.boldMedium(),
                  ),
                  SizedBox(height: 10),
                  Html(
                    data: model.productDetail.description ?? '',
                  ),
                ]),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ValueListenableBuilder(
            valueListenable: appOrderFromServer,
            builder: (_, Order? order, child) {
              return Visibility(
                visible: (appOrderFromServer.value != null &&
                    appOrderFromServer.value!.carts.isNotEmpty),
                child: Container(
                  color: theme_blue_color_1,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '\$${order?.total.toStringAsFixed(2) ?? ''}',
                            style: TSB.semiBoldLarge(textColor: Colors.white),
                          ),
                          Container(
                            width: 1,
                            height: 29,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            color: Colors.white,
                          ),
                          Text(
                            _getItemsCount(order),
                            style: TSB.regularMedium(textColor: Colors.white),
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
                              style: TSB.semiBoldSmall(textColor: Colors.white),
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
        )
      ],
    );
  }

  _getItemsCount(Order? order) {
    if (order != null) {
      return '${order.carts.length} ${order.carts.length > 1 ? 'Items' : 'Item'}';
    }
    return '';
  }
}
