import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/remote_urls.dart';
import '../../product_details/model/product_details_model.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';
import '../controller/bloc/bloc/chat_bloc.dart';
import '../controller/cubit/inbox_cubit.dart';
import '../models/send_message_model.dart';

class DisplayProductCard extends StatelessWidget {
  const DisplayProductCard(
      {Key? key, required this.productDetailsModel, required this.onChange})
      : super(key: key);
  final ProductDetailsModel productDetailsModel;
  final ValueChanged<bool> onChange;

  @override
  Widget build(BuildContext context) {
    final chatBloc = context.read<ChatBloc>();
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(color: const Color(0xff222222), boxShadow: [
        BoxShadow(
          blurRadius: 15,
          offset: const Offset(0, 2),
          color: Colors.black.withOpacity(0.2),
        )
      ]),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: CustomImage(
                path:
                    RemoteUrls.imageUrl(productDetailsModel.product.thumbImage),
                fit: BoxFit.contain,
              )),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  productDetailsModel.product.name,
                  //
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
                Text(
                  // Utils.formatPrice(Utils.productPrice(context, ), context),
                  Utils.formatPrice(
                      productDetailsModel.product.offerPrice != 0
                          ? productDetailsModel.product.offerPrice
                          : productDetailsModel.product.price,
                      context),

                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.red),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 35,
                    width: 100,
                    child: PrimaryButton(
                        borderRadiusSize: 4,
                        text: "Send",
                        onPressed: () {
                          chatBloc.add(
                            SendMsgData(
                              SendMsgModel(
                                sellerId: productDetailsModel
                                    .sellerProfile!.sellerUserId
                                    .toString(),
                                message: "",
                                productId:
                                    productDetailsModel.product.id.toString(),
                              ),
                            ),
                          );
                          context.read<InboxCubit>().reset();
                          onChange(true);
                        }),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
