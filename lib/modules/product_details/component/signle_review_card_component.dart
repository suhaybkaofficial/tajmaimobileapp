import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../model/details_product_reviews_model.dart';

class SingleReviewCardComponent extends StatelessWidget {
  const SingleReviewCardComponent(
    this.reviewModel, {
    Key? key,
  }) : super(key: key);

  final DetailsProductReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage:
                NetworkImage(RemoteUrls.imageUrl(reviewModel.user.image ?? '')),
            radius: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(reviewModel.user.name,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 18,
                              height: 1,
                              fontWeight: FontWeight.w600)),
                    ),
                    Text(
                      Utils.timeAgo(reviewModel.createdAt),
                      style: const TextStyle(
                          color: iconGreyColor, height: 1, fontSize: 12),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                RatingBar.builder(
                  initialRating: Utils.toDouble(reviewModel.rating.toString()),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  itemSize: 14,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Text(
                  reviewModel.review,
                  style: const TextStyle(color: iconGreyColor, height: 1.85),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
