import 'package:flutter/material.dart';
import 'package:shared/colors.dart';
import 'package:shared/simple_icon_widget.dart';
import 'package:shared/text_styles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class UserLocationView extends ViewModelWidget<HomeViewModel> {
  const UserLocationView({super.key});

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return viewModel.address.isEmpty
        ? _locationLoadingView()
        : _userLocationView(viewModel);
  }

  _locationLoadingView() {
    return Shimmer.fromColors(
      highlightColor: Colors.grey[50]!,
      baseColor: Colors.grey[200]!,
      period: const Duration(milliseconds: 2000),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Row(
          children: [
            Icon(Icons.location_on_outlined, color: theme_blue_color_1),
            SizedBox(width: 10),
            Flexible(child: Container(height: 25, color: Colors.grey)),
          ],
        ),
        trailing: SimpleIconWidget(
          onTap: () {
            // TODO: implement
          },
          icon: Icons.edit_outlined,
        ),
      ),
    );
  }

  _userLocationView(HomeViewModel model) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Icon(Icons.location_on_outlined, color: theme_blue_color_1),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              model.address,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TSB.boldMedium(textColor: black_text_color),
            ),
          ),
        ],
      ),
      trailing:
          SimpleIconWidget(onTap: model.editIconTap, icon: Icons.edit_outlined),
    );
  }
}
