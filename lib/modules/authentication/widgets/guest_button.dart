import 'package:flutter/material.dart';
import '/widgets/capitalized_word.dart';

import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';

class GuestButton extends StatelessWidget {
  const GuestButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.mainPage, (route) => false);
      },
      child:  Text(
        Language.continueAsGuest.capitalizeByWord(),
        style: const TextStyle(
          fontSize: 16,
          height: 1,
          color: deepGreenColor,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
        ),
      ),

      // style: OutlinedButton.styleFrom(
      //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      //   minimumSize: const Size(200, 44),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(4),
      //   ),
      //   side: const BorderSide(color: paragraphColor, width: 1),
      // ),
    );
  }
}
