import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';
import '../../../widgets/custom_image.dart';
import '../../home/model/product_model.dart';

class FeedbackProductCard extends StatelessWidget {
  const FeedbackProductCard({Key? key, required this.product})
      : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    const double height = 120;
    return Container(
      height: height,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xffE8EEF2)),
        color: const Color(0xffE8EEF2),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CustomImage(
              path: product.thumbImage,
              fit: BoxFit.cover,
              height: 85,
              width: 85,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      height: 1.5, fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: redColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: const [
                    Icon(Icons.star, color: redColor),
                    SizedBox(width: 5),
                    // Text(
                    //   product.rating.toStringAsFixed(1),
                    //   style: const TextStyle(
                    //       fontSize: 18,
                    //       color: Color(0xff8B8F97),
                    //       fontWeight: FontWeight.w600),
                    // )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
