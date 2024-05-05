import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../../category/component/price_card_widget.dart';
import '../../setting/model/website_setup_model.dart';
import '../controller/cubit/product_details_cubit.dart';

class ProductPriceWidget extends StatefulWidget {
  const ProductPriceWidget({super.key, required this.price});

  final double price;

  @override
  State<ProductPriceWidget> createState() => _ProductPriceWidgetState();
}

class _ProductPriceWidgetState extends State<ProductPriceWidget> {
  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductDetailsCubit>().productDetails;
    final appSetting = context.read<AppSettingCubit>();
    double flashPrice = 0.0;
    double offerPrice = 0.0;
    double mainPrice = widget.price;
    final isFlashSale = appSetting.settingModel!.flashSaleProducts
        .contains(FlashSaleProductsModel(productId: product!.product.id));
    int flashSaleActive = appSetting.settingModel!.flashSale.status;

    print('product_offer_price ${product.product.offerPrice}');
    if (product.product.offerPrice != 0.0) {
      print('product_price_not_null');
      if (product.product.activeVariantModel.isNotEmpty) {
        double p = 0.0;
        for (var i in product.product.activeVariantModel) {
          if (i.activeVariantsItems.isNotEmpty) {
            p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
          }
        }
        offerPrice = p + product.product.offerPrice;
      } else {
        offerPrice = product.product.offerPrice;
      }
    } else {
      print('product_price_null');
      print('product_price_null');
    }
    if (product.product.activeVariantModel.isNotEmpty) {
      double p = 0.0;
      for (var i in product.product.activeVariantModel) {
        if (i.activeVariantsItems.isNotEmpty) {
          p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
        }
      }
      mainPrice = p + product.product.price;
    } else {
      mainPrice = product.product.price;
    }

    if (isFlashSale && flashSaleActive == 1) {
      if (product.product.offerPrice != 0) {
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

    product.product.copyWith(
      offerPrice: isFlashSale ? flashPrice : offerPrice,
      price: mainPrice,
    );
    if (isFlashSale) {
      return PriceCardWidget(
        price: mainPrice.toString(),
        offerPrice: flashPrice.toString(),
        textSize: 22,
      );
    } else {
      return PriceCardWidget(
        price: mainPrice.toString(),
        offerPrice: offerPrice.toString(),
        textSize: 22,
      );
    }
  }
}
