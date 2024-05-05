import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_o/widgets/capitalized_word.dart';

import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../controllers/cart/cart_cubit.dart';
import '../model/cart_product_model.dart';

class AddToCartComponent extends StatefulWidget {
  const AddToCartComponent(
      {Key? key,
      required this.product,
      required this.onChange,
      required this.appSetting})
      : super(key: key);

  final CartProductModel product;
  final ValueChanged<int> onChange;
  final AppSettingCubit appSetting;

  @override
  State<AddToCartComponent> createState() => _AddToCartComponentState();
}

class _AddToCartComponentState extends State<AddToCartComponent> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;

    ///Price calculate state
    // double flashPrice = 0.0;
    // double offerPrice = 0.0;
    // double mainPrice = 0.0;
    // final isFlashSale = widget.appSetting.settingModel!.flashSaleProducts
    //     .contains(FlashSaleProductsModel(
    //         productId: widget.product.product.id.toString()));
    //
    // if (widget.product.product.offerPrice != 0) {
    //   if (widget.product.product.productVariants.isNotEmpty) {
    //     double p = 0.0;
    //     for (var i in widget.product.product.productVariants) {
    //       if (i.activeVariantsItems.isNotEmpty) {
    //         p += Utils.toDouble(i.activeVariantsItems.first.price);
    //       }
    //     }
    //     offerPrice = p + double.parse(widget.product.product.offerPrice);
    //   } else {
    //     offerPrice = double.parse(widget.product.product.offerPrice);
    //   }
    // }
    // if (widget.product.product.productVariants.isNotEmpty) {
    //   double p = 0.0;
    //   for (var i in widget.product.product.productVariants) {
    //     if (i.activeVariantsItems.isNotEmpty) {
    //       p += Utils.toDouble(i.activeVariantsItems.first.price);
    //     }
    //   }
    //   mainPrice = p + double.parse(widget.product.product.price);
    // } else {
    //   mainPrice = double.parse(widget.product.product.price);
    // }
    //
    // if (isFlashSale) {
    //   if (widget.product.product.offerPrice != 0) {
    //     final discount =
    //         double.parse(widget.appSetting.settingModel!.flashSale.offer) /
    //             100 *
    //             offerPrice;
    //
    //     flashPrice = offerPrice - discount;
    //   } else {
    //     final discount =
    //         double.parse(widget.appSetting.settingModel!.flashSale.offer) /
    //             100 *
    //             mainPrice;
    //
    //     flashPrice = mainPrice - discount;
    //   }
    // }

    ///Price calculate end

    const double height = 120;
    int value = widget.product.qty;
    return Container(
      height: height,
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
            height: height - 2,
            width: width / 2.7,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(4)),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.productDetailsScreen,
                      arguments: widget.product.product.slug);
                },
                child: CustomImage(
                  path: RemoteUrls.imageUrl(widget.product.product.thumbImage),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AutoSizeText(widget.product.product.name,
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          maxFontSize: 14,
                          minFontSize: 11,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                          )),
                    ),
                    InkWell(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    Language.confirmation.capitalizeByWord()),
                                content: const Text(
                                    "Are you sure you wish to remove this item?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text(
                                        Language.cancel.capitalizeByWord()),
                                  ),
                                  TextButton(
                                      onPressed: () async {
                                        final result = await context
                                            .read<CartCubit>()
                                            .removerCartItem(
                                                widget.product.id.toString());
                                        widget.product;

                                        result.fold(
                                          (failure) {
                                            // setState(() {});
                                            Utils.errorSnackBar(
                                                context, failure.message);
                                          },
                                          (success) {
                                            widget.onChange(widget.product.id);
                                            Utils.showSnackBar(
                                                context, success);
                                          },
                                        );
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text(
                                          Language.delete.capitalizeByWord())),
                                ],
                              );
                            },
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            Icons.clear_sharp,
                            size: 20,
                            color: redColor,
                          ),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      Utils.formatPrice(
                          Utils.cartProductPrice(context, widget.product),
                          context),
                      style: const TextStyle(
                        color: redColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: widget.product.qty > 1
                          ? () async {
                              final result = await context
                                  .read<CartCubit>()
                                  .decrementQuantity(
                                      widget.product.id.toString());

                              result.fold(
                                (failure) {
                                  // setState(() {});
                                  Utils.errorSnackBar(context, failure.message);
                                },
                                (success) {
                                  // widget.onChange(widget.product.id);
                                  // Utils.showSnackBar(context, success);
                                  Future.microtask(() => context
                                      .read<CartCubit>()
                                      .getCartProducts());
                                  // value--;
                                  // setState(() {
                                  //
                                  // });
                                },
                              );
                            }
                          : null,
                      child: Icon(Icons.remove_circle,
                          color: Utils.dynamicPrimaryColor(context)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 5),
                      child: Text(
                        value.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final result = await context
                            .read<CartCubit>()
                            .incrementQuantity(widget.product.id.toString());

                        result.fold(
                          (failure) {
                            // setState(() {});
                            Utils.errorSnackBar(context, failure.message);
                          },
                          (success) {
                            // widget.onChange(widget.product.id);
                            // Utils.showSnackBar(context, success);
                            Future.microtask(() =>
                                context.read<CartCubit>().getCartProducts());
                            // value++;
                            // setState(() {

                            // });
                          },
                        );
                      },
                      child: Icon(Icons.add_circle,
                          color: Utils.dynamicPrimaryColor(context)),
                    ),
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
