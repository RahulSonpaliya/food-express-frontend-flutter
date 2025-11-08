import 'package:flutter/material.dart';

import 'text_styles.dart';

PreferredSizeWidget getAppBar(title, {bool showBack = false, onBackPressed}) {
  return AppBar(
    title: Text(
      title,
      style: TSB.boldMedium(),
    ),
    leading: showBack
        ? IconButton(icon: Icon(Icons.arrow_back), onPressed: onBackPressed)
        : null,
    titleSpacing: showBack ? 0 : NavigationToolbar.kMiddleSpacing,
    automaticallyImplyLeading: showBack,
    elevation: 0,
    backgroundColor: Colors.white,
  );
}
