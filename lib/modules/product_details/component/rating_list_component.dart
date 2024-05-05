import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_o/utils/language_string.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../model/details_product_reviews_model.dart';
import 'signle_review_card_component.dart';

class ReviewListComponent extends StatelessWidget {
  const ReviewListComponent(
    this.productReviews, {
    Key? key,
  }) : super(key: key);

  final List<DetailsProductReviewModel> productReviews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildRatingHeader(),
          Container(height: 1, color: borderColor),
          const SizedBox(height: 30),
          ...productReviews
              .take(3)
              .map((e) => SingleReviewCardComponent(e))
              .toList(),
          if (productReviews.length > 3)
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, RouteNames.reviewListScreen,
                  //     arguments: productReviews);
                },
                child:  Text(
                 Language.seeAllReview,
                  style: const TextStyle(color: redColor),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildRatingHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Text(
            Utils.getRating(productReviews).toStringAsFixed(1),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingBar.builder(
                initialRating: Utils.getRating(productReviews),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                itemCount: 5,
                itemSize: 20,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
              // const SizedBox(height: 12),
              Text(
                '${productReviews.length} ${Language.reviews}',
                style: const TextStyle(fontSize: 16, color: iconGreyColor),
              )
            ],
          ),
        ],
      ),
    );
  }
}
