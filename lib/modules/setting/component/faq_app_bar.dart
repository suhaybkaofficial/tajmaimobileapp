import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class FaqAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const FaqAppBar({
    Key? key,
    this.onTap,
    this.height = 60,
  }) : super(key: key);
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(
                height: height - 20,
                decoration: BoxDecoration(
                  color: Utils.dynamicPrimaryColor(context),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget faqSearchBar() {
    return Positioned(
      bottom: 0,
      left: 20,
      right: 20,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 10),
          ],
        ),
        child: TextFormField(
          decoration: inputDecorationTheme.copyWith(
            prefixIcon: const Icon(Icons.search, size: 26),
            hintText: 'Search Name...',
            contentPadding: const EdgeInsets.symmetric(
              vertical: 11,
              horizontal: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
