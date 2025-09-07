import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared/app_images.dart';
import 'package:shared/colors.dart';
import 'package:shared/text_styles.dart';
import 'package:stacked/stacked.dart';

import '../../../../../data/model/bean/category.dart';
import '../../../../../data/model/bean/market.dart';
import 'product_list_viewmodel.dart';

class ProductListView extends StatefulWidget {
  final Category category;
  final onTapProduct;
  final Market market;

  const ProductListView({
    super.key,
    required this.category,
    this.onTapProduct,
    required this.market,
  });

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductListViewModel>.reactive(
        builder: (_, model, child) {
          if (model.busy(model.productList)) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (model.productList.isEmpty) {
              return Center(
                child: Text('Products not found'),
              );
            }
            return ListView.separated(
                itemBuilder: (_, i) {
                  var p = model.productList[i];
                  return InkWell(
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: p.image ?? '',
                                  fit: BoxFit.cover,
                                  placeholder: (_, url) => Image.asset(
                                    AppImages.defaultImage,
                                    width: 85,
                                    height: 85,
                                  ),
                                  width: 85,
                                  height: 85,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        p.name,
                                        style: TSB.semiBoldMedium(),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      if (p.options?.isNotEmpty ?? false)
                                        Column(
                                          children: [
                                            Text(
                                              p.options![0].variant_name,
                                              style: TSB.regularSmall(
                                                  textColor:
                                                      theme_text_hint_color),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      Text(
                                        '\$${(p.options?.isEmpty ?? true) ? p.price.toStringAsFixed(2) : p.options![0].price.toStringAsFixed(2)}',
                                        style: TSB.semiBoldSmall(
                                            textColor: theme_blue_color_1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // TODO implement
                          // ValueListenableBuilder(
                          //     valueListenable: appOrderFromServer,
                          //     builder: (_, Order order, child) {
                          //       return PlusMinusBtn(
                          //         plusClick: () => model.plusClick(p),
                          //         minusClick: () => model.minusClick(p),
                          //         showMinus: model.showMinus(p),
                          //         qty: model.getQty(p),
                          //       );
                          //     })
                        ],
                      ),
                    ),
                    onTap: () => widget.onTapProduct(p),
                  );
                },
                separatorBuilder: (_, i) {
                  return Padding(
                    padding: EdgeInsets.only(left: 100, top: 5, bottom: 10),
                    child: Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  );
                },
                itemCount: model.productList.length);
          }
        },
        viewModelBuilder: () =>
            ProductListViewModel(widget.category, widget.market));
  }

  @override
  bool get wantKeepAlive => true;
}
