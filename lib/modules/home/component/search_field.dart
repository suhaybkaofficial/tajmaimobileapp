import 'package:flutter/material.dart';
import '/widgets/capitalized_word.dart';

import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      // width: double.infinity,
      decoration: const BoxDecoration(
        color:  Color(0xffF6F6F6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: TextFormField(
        onTap: () {
          Utils.closeKeyBoard(context);
          Navigator.pushNamed(context, RouteNames.productSearchScreen);
        },
        decoration: inputDecorationTheme.copyWith(
          prefixIcon: Icon(Icons.search_rounded, color: grayColor, size: 20),
          hintText: Language.searchProduct.capitalizeByWord(),
          hintStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: grayColor),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 11,
            horizontal: 16,
          ),
          // suffixIconConstraints:
          //     const BoxConstraints(maxHeight: 32, minWidth: 32),
        ),
      ),

    );
  }
}
