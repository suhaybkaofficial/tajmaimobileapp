import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../widgets/app_bar_leading.dart';

class SearchAppBar extends AppBar {
  final Widget? titleWidget;
  final Color bgColor;
  final Color textColor;
  final void Function()? onTap;

  SearchAppBar({
    this.titleWidget,
    this.textColor = Colors.white,
    this.bgColor = appBgColor,
    this.onTap,
    Key? key,
  }) : super(
          key: key,
          titleSpacing: 0,
          backgroundColor: bgColor,
          leading: const AppbarLeading(),
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: textColor, fontSize: 18, fontWeight: FontWeight.w600),
          title: titleWidget,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        );
}
