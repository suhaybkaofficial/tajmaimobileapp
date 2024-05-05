import 'package:flutter/material.dart';

import '/modules/animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../model/cart_product_model.dart';

class CheckoutSingleItem extends StatelessWidget {
  const CheckoutSingleItem(
      {super.key, required this.product, required this.appSetting});

  final CartProductModel product;
  final AppSettingCubit appSetting;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    // if (product.variants.isNotEmpty) {
    //   print('text-variants ${product.variants.first.varientItem!.name}');
    // } else {
    //   print('text-variants-null ${product.variants}');
    // }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: borderColor)),
            ),
            constraints: BoxConstraints(
              maxHeight: 120,
              maxWidth: width / 2.7,
            ),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(4)),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.productDetailsScreen,
                      arguments: product.product.slug);
                },
                child: CustomImage(
                  path: RemoteUrls.imageUrl(product.product.thumbImage),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    product.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Utils.formatPrice(
                          Utils.cartProductPrice(context, product), context),
                      style: const TextStyle(
                          color: redColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        'x ${product.qty}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                // Wrap(
                //   children: product.variants
                //       .map(
                //         (e) => Text(
                //           '${e.varientItem!.productVariantName} : ${e.varientItem!.name ?? ''}, ',
                //           style: const TextStyle(fontSize: 10),
                //         ),
                //       )
                //       .toList(),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
