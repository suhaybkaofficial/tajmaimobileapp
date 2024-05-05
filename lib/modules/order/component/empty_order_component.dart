import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/widgets/capitalized_word.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/language_string.dart';
import '../../../widgets/custom_image.dart';

class EmptyOrderComponent extends StatelessWidget {
  const EmptyOrderComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(
          children: [
            const CustomImage(path: Kimages.emptyOrder),
            const SizedBox(height: 34),
            Text(
              '${Language.noItemsFound.capitalizeByWord()}!',
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.bold, height: 2),
            ),
            const SizedBox(height: 9),
             Text(
             Language.noCartItem.capitalizeByWord() ,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: iconGreyColor, height: 1.5),
            ),
            const SizedBox(height: 30),
            // SizedBox(
            //   width: 200,
            //   child: PrimaryButton(
            //     text: 'Order Products Now',
            //     onPressed: () {},
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
