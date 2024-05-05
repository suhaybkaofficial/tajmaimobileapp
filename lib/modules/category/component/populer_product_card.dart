import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../../home/model/product_model.dart';

class PopulerProductCard extends StatelessWidget {
  final ProductModel productModel;
  const PopulerProductCard({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double height = 125;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.productDetailsScreen,
            arguments: productModel.slug);
      },
      child: Container(
        height: height,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(height),
            const SizedBox(width: 14),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(double height) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: borderColor)),
      ),
      height: height,
      width: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(4)),
            child: CustomImage(
              path: RemoteUrls.imageUrl(productModel.thumbImage),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: FavoriteButton(productId: productModel.id),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingBar.builder(
              initialRating: productModel.rating,
              minRating: 3,
              direction: Axis.horizontal,
              allowHalfRating: true,
              ignoreGestures: true,
              itemCount: 5,
              itemSize: 20,
              glow: true,
              glowColor: Utils.dynamicPrimaryColor(context),
              tapOnlyMode: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Color(0xffF6D060),
              ),
              onRatingUpdate: (rating) {},
            ),
            const SizedBox(height: 10),
            Text(
              productModel.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  Utils.formatPrice(productModel.price, context),
                  style: const TextStyle(
                      color: redColor,
                      height: 1.5,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 6),
                Text(
                  Utils.formatPrice(productModel.offerPrice, context),
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Color(0xff85959E),
                    height: 1.5,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
