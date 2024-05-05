import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '/modules/animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '/modules/cart/model/cart_calculation_model.dart';
import '/widgets/capitalized_word.dart';
import '../../utils/constants.dart';
import '../../utils/language_string.dart';
import '../../utils/utils.dart';
import '../../widgets/please_signin_widget.dart';
import '../../widgets/rounded_app_bar.dart';
import 'component/add_to_cart_component.dart';
import 'component/panel_widget.dart';
import 'controllers/cart/cart_cubit.dart';
import 'model/cart_response_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    loadCart();
  }

  loadCart() {
    Future.microtask(() => context.read<CartCubit>().getCartProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: Language.cart.capitalizeByWord()),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (_, state) {
          if (state is CartStateDecIncrementLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (state is CartStateDecIncError) {
              if (!state.message.contains("cached")) {
                Utils.errorSnackBar(context, state.message);
              }
            }
            if (state is CartStateRemove) {
              Utils.showSnackBar(context, state.message);
            }
            if (state is CartDecIncState) {
              Utils.showSnackBar(context, state.message);
            }
          }
        },
        builder: (context, state) {
          if (state is CartStateLoading || state is CartStateInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartStateError) {
            if (state.statusCode == 401) {
              return const PleaseSigninWidget();
            }
            if (state.statusCode == 503) {
              return const _LoadedWidget();
            } else {
              return Center(child: Text(state.message));
            }
          }
          return const _LoadedWidget();
        },
      ),
    );
  }
}

class _LoadedWidget extends StatefulWidget {
  const _LoadedWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_LoadedWidget> createState() => _LoadedWidgetState();
}

class _LoadedWidgetState extends State<_LoadedWidget> {
  final panelController = PanelController();
  Map<String, dynamic> map = <String, dynamic>{};

  final double height = 120;
  late double subTotal;
  late double total;
  late double variantPrice;
  late String coupon;

  CartResponseModel? cartResponseModel;
  CartCalculation? cartCalculation;

  @override
  void initState() {
    super.initState();
    cartResponseModel = context.read<CartCubit>().cartResponseModel;
    calculate();
  }

  calculate() {
    subTotal = 0.0;
    total = 0.0;
    variantPrice = 0.0;
    coupon = "";
    if (cartResponseModel!.cartProducts.isEmpty) {
      cartCalculation = const CartCalculation(
        subTotal: 0.0,
        coupon: "",
        total: 0.0,
      );
    } else {
      cartResponseModel!.cartProducts.map((e) {
        // if (e.product.offerPrice != 0) {
        //   subTotal += double.parse(e.product.offerPrice) * double.parse(e.qty);
        // } else {
        //   subTotal += double.parse(e.product.price) * double.parse(e.qty);
        // }

        subTotal += Utils.cartProductPrice(context, e) * e.qty.toDouble();
        // e.variants.map((e) {
        //   variantPrice += double.parse(e.varientItem.price);
        // }).toList();
      }).toList();
      total = subTotal;
      context.read<CartCubit>().getCoupon();

      if (context.read<CartCubit>().couponResponseModel != null) {
        debugPrint("HE");
        coupon =
            context.read<CartCubit>().couponResponseModel!.discount.toString();
        total = total - double.parse(coupon);
      }

      cartCalculation = CartCalculation(
        subTotal: subTotal,
        coupon: coupon,
        total: total,
      );

      context.read<CartCubit>().saveCartCalculation(cartCalculation!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (cartResponseModel == null) return const SizedBox();

        return SlidingUpPanel(
          controller: panelController,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          panelBuilder: (sc) => PanelComponent(
            controller: sc,
            cartResponseModel: cartResponseModel!,
            cartCalculation: cartCalculation!,
          ),
          minHeight: height,
          maxHeight: 350,
          backdropEnabled: true,
          backdropTapClosesPanel: true,
          parallaxEnabled: true,
          backdropOpacity: .0,
          collapsed: PanelCollapseComponent(
            height: height,
            cartResponseModel: cartResponseModel!,
            totalPrice: cartCalculation!.total,
          ),
          body: _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() {
    final appSetting = context.read<AppSettingCubit>();
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
            child: Row(
              children: [
                const Icon(Icons.shopping_cart_rounded, color: redColor),
                const SizedBox(width: 10),
                Text(
                  _getText(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return AddToCartComponent(
                  product: cartResponseModel!.cartProducts[index],
                  onChange: (int id) {
                    cartResponseModel!.cartProducts
                        .removeWhere((element) => element.id == id);
                    setState(() {
                      calculate();
                    });
                  },
                  appSetting: appSetting,
                );
              },
              childCount: cartResponseModel!.cartProducts.length,
              addAutomaticKeepAlives: true,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 245)),
      ],
    );
  }

  String _getText() {
    final length = cartResponseModel!.cartProducts.length;
    if (length > 1) {
      return '$length ${Language.products.capitalizeByWord()}';
    } else {
      return '$length ${Language.product.capitalizeByWord()}';
    }
  }
}
