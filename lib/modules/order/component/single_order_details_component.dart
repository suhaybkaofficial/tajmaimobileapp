import 'package:flutter/material.dart';
import 'package:shop_o/widgets/capitalized_word.dart';

import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../model/product_order_model.dart';

class SingleOrderDetailsComponent extends StatelessWidget {
  const SingleOrderDetailsComponent({
    Key? key,
    required this.orderItem,
    this.isOrdered = false,
  }) : super(key: key);

  final bool isOrdered;

  final OrderedProductModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 14, left: 14),
      child: InkWell(
        onTap: () {
          // Navigator.pushNamed(context, RouteNames.productDetailsScreen,
          //     arguments: orderItem.slug);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomImage(
            //   path: RemoteUrls.imageUrl(orderItem.thumbImage),
            //   height: 70,
            //   width: 70,
            //   fit: BoxFit.cover,
            // ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderItem.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        height: 1.3, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'X ${orderItem.qty}',
                    style: TextStyle(color: blackColor.withOpacity(.6)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Utils.formatPrice(orderItem.unitPrice,context)),
                      if (isOrdered)
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.submitFeedBackScreen,
                                arguments: orderItem);
                          },
                          child:  Text(
                            Language.reviews.capitalizeByWord(),
                            style: const TextStyle(color: redColor),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
