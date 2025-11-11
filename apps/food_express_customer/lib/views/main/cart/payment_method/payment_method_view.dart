import 'package:flutter/material.dart';
import 'package:shared/app_bar.dart';
import 'package:stacked/stacked.dart';

import 'add_card_view.dart';
import 'card_list_view.dart';
import 'payment_method_viewmodel.dart';

class PaymentMethodView extends StatefulWidget {
  @override
  _PaymentMethodViewState createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentMethodViewModel>.reactive(
        builder: (_, model, child) {
          return WillPopScope(
            child: Scaffold(
              appBar: getAppBar('Payment Method',
                  showBack: true, onBackPressed: () => _backPress(model)),
              body: model.busy(model.cards)
                  ? _showLoading()
                  : _showContent(model),
            ),
            onWillPop: () async {
              _backPress(model);
              return false;
            },
          );
        },
        viewModelBuilder: () => PaymentMethodViewModel());
  }

  _backPress(PaymentMethodViewModel model) {
    if (model.cards?.isEmpty ?? true) {
      model.navigateBack();
    } else {
      if (_tabController.index == 0) {
        model.navigateBack();
      } else {
        _tabController.animateTo(0);
      }
    }
  }

  _showLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _showContent(PaymentMethodViewModel model) {
    if (model.cards?.isEmpty ?? true) {
      return AddCardView();
    } else {
      return TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            CardListView(() {
              _tabController.animateTo(1);
            }),
            AddCardView(),
          ]);
    }
  }
}
