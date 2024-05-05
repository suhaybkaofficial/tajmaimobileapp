import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_o/utils/k_images.dart';
import 'package:shop_o/utils/language_string.dart';
import 'package:shop_o/widgets/capitalized_word.dart';

import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../model/product_details_model.dart';
import 'related_single_product_card.dart';

class SellerInfo extends StatelessWidget {
  const SellerInfo({Key? key, this.productDetailsModel}) : super(key: key);
  final ProductDetailsModel? productDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (productDetailsModel!.sellerProfile != null)
            SellerProfile(productDetailsModel: productDetailsModel!),

          SellerProducts(
            title: Language.products.capitalizeByWord(),
            value: productDetailsModel!.sellerTotalProducts.toString(),
          ),
          SellerProducts(
            title: Language.category.capitalizeByWord(),
            value: productDetailsModel!.product.category!.name,
          ),
          SellerProducts(
            title: Language.tags.capitalizeByWord(),
            value: productDetailsModel!.tags,
          ),

          productDetailsModel!.thisSellerProducts.isNotEmpty
              ? SizedBox(
                  height: 250 +
                      (10.0 * productDetailsModel!.thisSellerProducts.length),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 230,
                    ),
                    itemCount:
                        productDetailsModel!.thisSellerProducts.length < 4
                            ? productDetailsModel!.thisSellerProducts.length
                            : 4,
                    itemBuilder: (context, index) {
                      return RelatedSingleProductCard(
                          productModel:
                              productDetailsModel!.thisSellerProducts[index]);
                    },
                  ),
                )
              : const SizedBox(),
          // SliverGrid(
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 10,
          //     mainAxisSpacing: 10,
          //     mainAxisExtent: 230,
          //   ),
          //   delegate: SliverChildBuilderDelegate(
          //         (BuildContext context, int index) {
          //       return RelatedSingleProductCard(productModel:  productDetailsModel!.thisSellerProducts[index]);
          //     },
          //     childCount: productDetailsModel!.thisSellerProducts.length < 4 ? productDetailsModel!.thisSellerProducts.length : 4,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class SellerProfile extends StatelessWidget {
  const SellerProfile({
    Key? key,
    required this.productDetailsModel,
  }) : super(key: key);
  final ProductDetailsModel? productDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: grayColor,
              backgroundImage:
                  productDetailsModel!.sellerProfile!.user!.image != null
                      ? NetworkImage(RemoteUrls.imageUrl(
                          productDetailsModel!.sellerProfile!.user!.image!))
                      : const NetworkImage(Kimages.kDefaultUserImage),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productDetailsModel!.sellerProfile!.user!.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    productDetailsModel!.sellerProfile!.address,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: iconGreyColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating:
                            productDetailsModel!.sellerReviewQty!.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemSize: 15,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      Container(
                          width: 1,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          height: 24,
                          color: borderColor),
                      Text(
                        productDetailsModel!.sellerTotalReview.toString(),
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w300),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),
      ],
    );
  }
}

class SellerProducts extends StatelessWidget {
  const SellerProducts({
    Key? key,
    this.title,
    this.value,
  }) : super(key: key);
  final String? title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          text: "$title: ",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.2,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: "$value",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 1.2,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
