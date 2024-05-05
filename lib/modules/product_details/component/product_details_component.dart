import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_o/core/data/datasources/remote_data_source_packages.dart';
import 'package:shop_o/widgets/capitalized_word.dart';

import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../../category/component/price_card_widget.dart';
import '../model/product_details_product_model.dart';

class ProductDetailsComponent extends StatefulWidget {
  const ProductDetailsComponent(
      {required this.product, required this.detailsModel, super.key});

  final ProductDetailsProductModel product;
  final ProductDetailsModel detailsModel;

  @override
  State<ProductDetailsComponent> createState() =>
      _ProductDetailsComponentState();
}

class _ProductDetailsComponentState extends State<ProductDetailsComponent> {
  @override
  Widget build(BuildContext context) {
    final appSetting = context.read<AppSettingCubit>();
    double flashPrice = 0.0;
    double offerPrice = 0.0;
    double mainPrice = 0.0;
    final isFlashSale = appSetting.settingModel!.flashSaleProducts
        .contains(FlashSaleProductsModel(productId: widget.product.id));
    int flashSaleActive = appSetting.settingModel!.flashSale.status;

    print('product_offer_price ${widget.product.offerPrice}');
    if (widget.product.offerPrice != 0.0) {
      print('product_price_not_null');
      if (widget.product.activeVariantModel.isNotEmpty) {
        double p = 0.0;
        for (var i in widget.product.activeVariantModel) {
          if (i.activeVariantsItems.isNotEmpty) {
            p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
          }
        }
        offerPrice = p + widget.product.offerPrice;
      } else {
        offerPrice = widget.product.offerPrice;
      }
    } else {
      print('product_price_null');
      print('product_price_null');
    }
    if (widget.product.activeVariantModel.isNotEmpty) {
      double p = 0.0;
      for (var i in widget.product.activeVariantModel) {
        if (i.activeVariantsItems.isNotEmpty) {
          p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
        }
      }
      mainPrice = p + widget.product.price;
    } else {
      mainPrice = widget.product.price;
    }

    if (isFlashSale && flashSaleActive == 1) {
      if (widget.product.offerPrice != 0) {
        print(
            'FLASH_SALE_OFFER_NOT_NULL ${appSetting.settingModel!.flashSale.offer}');
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * offerPrice;

        flashPrice = offerPrice - discount;
      } else {
        print(
            'FLASH_SALE_OFFER_NULL ${appSetting.settingModel!.flashSale.offer}');
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * mainPrice;

        flashPrice = mainPrice - discount;
      }
    }

    widget.product.copyWith(
      offerPrice: isFlashSale ? flashPrice : offerPrice,
      price: mainPrice,
    );
    final qty = widget.product.qty;
    final availability = qty > 0
        ? '${widget.product.qty} ${Language.productsAvailable}'
        : Language.stockOut;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isFlashSale) ...[
            PriceCardWidget(
              price: mainPrice.toString(),
              offerPrice: flashPrice.toString(),
              textSize: 22,
            ),
          ] else ...[
            PriceCardWidget(
              price: mainPrice.toString(),
              offerPrice: offerPrice.toString(),
              textSize: 22,
            ),
          ],
          const SizedBox(height: 4),
          Text(
            widget.product.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          _builtRating(),
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${Language.availability.capitalizeByWord()}: ',
                  style: const TextStyle(
                      color: blackColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: availability,
                  style: const TextStyle(
                      color: blackColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            widget.product.shortDescription,
            textAlign: TextAlign.justify,
            style: const TextStyle(color: iconGreyColor),
          ),
          const SizedBox(height: 26),
        ],
      ),
    );
  }

  Widget _builtRating() {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: widget.product.averageRating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          ignoreGestures: true,
          itemCount: 5,
          itemSize: 15,
          itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
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
          Utils.getRating(widget.detailsModel.productReviews)
              .toStringAsFixed(1),
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}
