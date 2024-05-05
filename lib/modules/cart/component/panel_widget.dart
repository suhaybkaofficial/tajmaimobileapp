import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/cart/model/cart_calculation_model.dart';
import '/widgets/capitalized_word.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../controllers/cart/cart_cubit.dart';
import '../model/cart_response_model.dart';

class PanelCollapseComponent extends StatelessWidget {
  const PanelCollapseComponent(
      {Key? key,
      required this.height,
      required this.cartResponseModel,
      required this.totalPrice})
      : super(key: key);

  final CartResponseModel cartResponseModel;
  final double height;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
            height: 4,
            width: 60,
          ),
          // const SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Language.orderAmount.capitalizeByWord(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                Utils.formatPrice(totalPrice, context),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 50,
            child: PrimaryButton(
              text: Language.checkout.capitalizeByWord(),
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.checkoutScreen);
              },
            ),
          )
        ],
      ),
    );
  }
}

class PanelComponent extends StatefulWidget {
  const PanelComponent({
    Key? key,
    this.controller,
    required this.cartResponseModel,
    required this.cartCalculation,
  }) : super(key: key);

  final CartResponseModel cartResponseModel;

  final ScrollController? controller;
  final CartCalculation? cartCalculation;

  @override
  State<PanelComponent> createState() => _PanelComponentState();
}

class _PanelComponentState extends State<PanelComponent> {
  final textController = TextEditingController();

  late CartResponseModel cResponse;

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.controller,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      children: [
        Text(Language.applyCoupon.capitalizeByWord()),
        const SizedBox(height: 8),
        Text(
          Language.billDetails.capitalizeByWord(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Language.subTotal.capitalizeByWord(),
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              Utils.formatPrice(widget.cartCalculation!.subTotal, context),
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
        const SizedBox(height: 8),
        _buildTextField(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Language.discountCoupon.capitalizeByWord(),
              style: const TextStyle(fontSize: 16, color: redColor),
            ),
            BlocConsumer<CartCubit, CartState>(listener: (context, state) {
              if (state is CartStateDecIncrementLoading) {
                Utils.loadingDialog(context);
              } else {
                Utils.closeDialog(context);
              }
            }, builder: (context, state) {
              if (state is CartStateError) {
                return Text(state.message);
              }
              if (state is CartCouponStateLoaded) {
                widget.cartCalculation!.copyWith(
                  total: (widget.cartCalculation!.total -
                      double.parse(
                          state.couponResponseModel.discount.toString())),
                );

                return Text(
                    Utils.formatPrice(
                        state.couponResponseModel.discount, context),
                    style: const TextStyle(fontSize: 16, color: redColor));
              }
              return const SizedBox();
            }),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 1,
          color: borderColor,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Language.total.capitalizeByWord(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              Utils.formatPrice(widget.cartCalculation!.total, context),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 50,
          child: PrimaryButton(
            text: Language.checkout.capitalizeByWord(),
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.checkoutScreen);
            },
          ),
        )
      ],
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        hintText: Language.promoCode.capitalizeByWord(),
        // contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        isDense: true,
        suffixIconConstraints:
            const BoxConstraints(maxHeight: 55, maxWidth: 85),
        suffixIcon: _buildSubmit(),
      ),
    );
  }

  Widget _buildSubmit() {
    return Container(
      width: 85,
      height: 54,
      decoration: BoxDecoration(
        color: Utils.dynamicPrimaryColor(context),
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(4),
        ),
      ),
      child: InkWell(
        onTap: () {
          // textController.clear();

          if (textController.text.isEmpty) return;
          // Utils.closeKeyBoard(context);
          context.read<CartCubit>().applyCoupon(textController.text.trim());
          textController.clear();
          setState(() {});
        },
        child: Center(
          child: Text(
            Language.apply.capitalizeByWord(),
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
