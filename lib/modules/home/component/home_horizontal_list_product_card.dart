import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../../category/component/price_card_widget.dart';
import '../../setting/model/website_setup_model.dart';
import '../model/product_model.dart';

class HomeHorizontalListProductCard extends StatelessWidget {
  final ProductModel productModel;

  const HomeHorizontalListProductCard({
    Key? key,
    this.height = 100,
    this.width = 215,
    required this.productModel,
  }) : super(key: key);
  final double height, width;

  @override
  Widget build(BuildContext context) {
    final appSetting = context.read<AppSettingCubit>();
    double flashPrice = 0.0;
    double offerPrice = 0.0;
    double mainPrice = 0.0;
    final isFlashSale = appSetting.settingModel!.flashSaleProducts
        .contains(FlashSaleProductsModel(productId: productModel.id));

    if (productModel.offerPrice != 0) {
      double p = 0.0;
      if (productModel.productVariants.isNotEmpty) {
        for (var i in productModel.productVariants) {
          if (i.activeVariantsItems.isNotEmpty) {
            p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
          }
        }
        offerPrice = p + productModel.offerPrice;
      } else {
        offerPrice = productModel.offerPrice;
      }
    }
    if (productModel.productVariants.isNotEmpty) {
      double p = 0.0;
      for (var i in productModel.productVariants) {
        if (i.activeVariantsItems.isNotEmpty) {
          p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
        }
      }
      mainPrice = p + productModel.price;
    } else {
      mainPrice = productModel.price;
    }
    if (isFlashSale) {
      if (productModel.offerPrice != 0) {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * offerPrice;

        flashPrice = offerPrice - discount;
      } else {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * mainPrice;

        flashPrice = mainPrice - discount;
      }
    }
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouteNames.productDetailsScreen,
              arguments: productModel.slug);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(right: BorderSide(color: borderColor)),
              ),
              height: height - 2,
              width: width / 2.7,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(4)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CustomImage(
                      path: RemoteUrls.imageUrl(productModel.thumbImage),
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                        left: 5.0,
                        top: 5.0,
                        child: FavoriteButton(productId: productModel.id))
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    initialRating: productModel.rating,
                    minRating: 1,
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
                      color: Colors.yellow,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  // const SizedBox(height: 5),
                  const SizedBox(height: 10),
                  AutoSizeText(productModel.name,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      maxFontSize: 16,
                      minFontSize: 12,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                          fontSize: 16)),

                  const SizedBox(height: 10),
                  if (isFlashSale) ...[
                    PriceCardWidget(
                      price: mainPrice.toString(),
                      offerPrice: flashPrice.toString(),
                    ),
                  ] else ...[
                    PriceCardWidget(
                      price: mainPrice.toString(),
                      offerPrice: offerPrice.toString(),
                    ),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
