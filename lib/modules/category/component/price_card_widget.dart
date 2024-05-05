import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class PriceCardWidget extends StatelessWidget {
  const PriceCardWidget({
    Key? key,
    required this.price,
    required this.offerPrice,
    this.textSize = 16,
  }) : super(key: key);
  final String price;
  final double textSize;
  final String offerPrice;

  @override
  Widget build(BuildContext context) {
    if (offerPrice == "0.0") {
      return _buildPrice(Utils.formatPrice(price,context));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildPrice(Utils.formatPrice(offerPrice,context)),
        const SizedBox(width: 10),
        Expanded(
          child: AutoSizeText(
            Utils.formatPrice(price,context),
            textAlign: TextAlign.left,
            maxFontSize: textSize - 4,minFontSize: textSize - 4,
            style:  TextStyle(
              decoration: TextDecoration.lineThrough,
              color: const Color(0xff85959E),
              height: 1.5,
              fontSize: textSize,
            ),
            maxLines: 1,
          ),
        )
      ],
    );
  }

  Widget _buildPrice(String price) {
    return Text(
      price,
      style: TextStyle(
          color: redColor,
          height: 1.5,
          fontSize: textSize,
          fontWeight: FontWeight.w600),
    );
  }
}

// offerPrice = 15;
// price = 25;
//
// afterDiscount = 0.2 * 25 = 5;
// finalOfferPrice = price - afterDiscount = 20;



// class PriceCardWidget extends StatelessWidget {
//   const PriceCardWidget({
//     Key? key,
//     required this.price,
//     required this.offerPrice,
//     this.textSize = 16,
//   }) : super(key: key);
//   final String price;
//   final double textSize;
//   final String offerPrice;
//
//   @override
//   Widget build(BuildContext context) {
//     if (offerPrice == "0.0") {
//       return _buildPrice(Utils.formatPrice(price));
//     }
//
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       // crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         AutoSizeText(
//           Utils.formatPrice(price),
//           textAlign: TextAlign.left,
//           maxFontSize: textSize - 4,minFontSize: textSize - 4,
//           style:  TextStyle(
//             // fontWeight: FontWeight.w500,
//             decoration: TextDecoration.lineThrough,
//             decorationColor: blackColor,
//             color: const Color(0xFF8E8E8E),
//             height: 1.5,
//             fontSize: textSize,
//           ),
//           maxLines: 1,
//         ),
//         const SizedBox(width: 10),
//         _buildPrice(Utils.formatPrice(offerPrice)),
//       ],
//     );
//   }
//
//   Widget _buildPrice(String price) {
//     return Text(
//       price,
//       style: GoogleFonts.roboto(
//           color: primaryColor,
//           height: 1.5,
//           fontSize: textSize,
//           fontWeight: FontWeight.w500),
//     );
//   }
// }

// offerPrice = 15;
// price = 25;
//
// afterDiscount = 0.2 * 25 = 5;
// finalOfferPrice = price - afterDiscount = 20;

