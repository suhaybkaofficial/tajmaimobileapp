import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/place_order/controllers/bank/bank_cubit.dart';
import '/modules/place_order/controllers/stripe/stripe_cubit.dart';
import '/utils/k_images.dart';
import '/utils/language_string.dart';
import '/widgets/custom_image.dart';
import '../../core/remote_urls.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/rounded_app_bar.dart';
import '../authentication/controller/login/login_bloc.dart';
import '../cart/model/checkout_response_model.dart';
import 'controllers/cash_on_payment/cash_on_payment_cubit.dart';
import 'controllers/payment/payment_cubit.dart';
import 'controllers/razorpay/razorpay_cubit.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  void initState() {
    super.initState();
  }

  CheckoutResponseModel? checkoutResponseModel;

  @override
  Widget build(BuildContext context) {
    // checkoutResponseModel  = context.read<CheckoutCubit>().checkoutResponseModel;
    // print('CCCC $checkoutResponseModel');
    final route =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final body = route['body'] as Map<String, dynamic>;
    final checkoutResponseModel = route['payment_status'];
    return MultiBlocListener(
      listeners: [
        BlocListener<CashOnPaymentCubit, CashPaymentState>(
          listener: (context, state) {
            if (state is CashPaymentStateLoading) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (state is CashPaymentStateLoaded) {
                Utils.showSnackBar(context, state.message);
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.orderScreen, (route) {
                  if (route.settings.name == RouteNames.mainPage) {
                    return true;
                  }
                  return false;
                });
              } else if (state is CashPaymentStateError) {
                Utils.errorSnackBar(context, state.message);
              }
            }
          },
        ),
        BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentLoading) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (state is PaymentLoaded) {
                Utils.showSnackBar(context, state.transactionResponse.message!);
              } else if (state is PaymentError) {
                Utils.errorSnackBar(context, state.message);
              }
            }
          },
        ),
        // BlocListener<PaypalCubit, PaypalState>(
        //   listener: (context, state) {
        //     if (state is PaypalStateLoading) {
        //       Utils.loadingDialog(context);
        //     } else {
        //       Utils.closeDialog(context);
        //       if (state is PaypalStateLoaded) {
        //         Navigator.pushNamed(context, RouteNames.paypalScreen,
        //             arguments: state.message);
        //       } else if (state is PaypalStateError) {
        //         Utils.errorSnackBar(context, state.message);
        //       }
        //     }
        //   },
        // ),
        BlocListener<StripeCubit, StripeState>(
          listener: (context, state) {
            if (state is StripeLoading) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (state is StripeLoaded) {
                Utils.showSnackBar(context, state.message);
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.orderScreen, (route) {
                  if (route.settings.name == RouteNames.mainPage) {
                    return true;
                  }
                  return false;
                });
              } else if (state is StripeError) {
                Utils.errorSnackBar(context, state.message);
              }
            }
          },
        ),
        BlocListener<BankCubit, BankState>(
          listener: (context, state) {
            if (state is BankStateLoading) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (state is BankLoadedState) {
                Utils.showSnackBar(context, state.message);
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.orderScreen, (route) {
                  if (route.settings.name == RouteNames.mainPage) {
                    return true;
                  }
                  return false;
                });
              } else if (state is BankStateError) {
                Utils.errorSnackBar(context, state.message);
              }
            }
          },
        ),
        BlocListener<RazorpayCubit, RazorpayState>(listener: (context, state) {
          if (state is RazorStateLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (state is RazorStateError) {
              Utils.errorSnackBar(context, state.message);
            } else if (state is RazorStateLoaded) {
              final amount = state.razorOrder['amount'];
              final orderId = state.razorOrder['order_id'];
              Utils.showSnackBar(context, "$amount | $orderId");
              String params =
                  "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}&request_from=flutter_app&amount=$amount&order_id=$orderId";
              final token = context.read<LoginBloc>().userInfo!.accessToken;
              // debugPrint(RemoteUrls.razorOrder(token, params));
              Navigator.pushNamed(context, RouteNames.razorpayScreen,
                  arguments: RemoteUrls.payWithRazorpayWeb(token, params));
            } else if (state is RazorStateError) {
              Utils.errorSnackBar(context, state.message);
            }
          }
        }),
      ],
      child: Scaffold(
        appBar: RoundedAppBar(titleText: 'Place Order'),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              Language.selectPaymentOption,
              style: const TextStyle(
                fontSize: 18,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 18),
            Visibility(
              visible:
                  checkoutResponseModel.bankStatus!.status == 1 ? true : false,
              child: PaymentCard(
                title: Language.cashOnDelivery,
                icon: Kimages.codIcon,
                press: () {
                  context.read<CashOnPaymentCubit>().cashOnDelivery(body);
                },
              ),
            ),
            Visibility(
              visible: checkoutResponseModel.stripe!.status == 1 ? true : false,
              child: PaymentCard(
                title: "Pay With Stripe",
                icon: Kimages.stripeIcon,
                press: () {
                  Navigator.pushNamed(context, RouteNames.stripeScreen,
                      arguments: body);
                },
              ),
            ),
            Visibility(
              visible: checkoutResponseModel.paypalStatus!.status == 1
                  ? true
                  : false,
              child: PaymentCard(
                title: "Pay With Paypal",
                icon: Kimages.paypalIcon,
                press: () {
                  String params =
                      "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}";
                  final token = context.read<LoginBloc>().userInfo!.accessToken;
                  debugPrint(RemoteUrls.payWithPaypalWeb(token, params));
                  Navigator.pushNamed(context, RouteNames.paypalScreen,
                      arguments: RemoteUrls.payWithPaypalWeb(token, params));
                },
              ),
            ),
            Visibility(
              visible: checkoutResponseModel.razorPayStatus!.status == 1
                  ? true
                  : false,
              child: PaymentCard(
                title: "Pay With Razorpay",
                icon: Kimages.razorpayIcon,
                press: () {
                  context.read<RazorpayCubit>().payWithRazor(body);
                },
              ),
            ),
            Visibility(
              visible:
                  checkoutResponseModel.flutterwave!.status == 1 ? true : false,
              child: PaymentCard(
                title: "Pay with Flutter-wave",
                icon: Kimages.flutterWaveIcon,
                press: () {
                  String params =
                      "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}&request_from=flutter_app";
                  final token = context.read<LoginBloc>().userInfo!.accessToken;
                  // debugPrint(RemoteUrls.razorOrder(token, params));
                  Navigator.pushNamed(context, RouteNames.flutterWaveScreen,
                      arguments: RemoteUrls.payWithFlutterWave(token, params));
                },
              ),
            ),
            Visibility(
              visible:
                  checkoutResponseModel.payStackMolliStatus!.mollieStatus == 1
                      ? true
                      : false,
              child: PaymentCard(
                title: "Pay With Mollie",
                icon: Kimages.mollieIcon,
                press: () async {
                  String params =
                      "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}&request_from=flutter_app";
                  final token = context.read<LoginBloc>().userInfo!.accessToken;
                  Navigator.pushNamed(context, RouteNames.molliePaymentScreen,
                          arguments: RemoteUrls.payWithMollieWeb(token, params))
                      .then((value) {
                    if (value == true) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteNames.orderScreen, (route) {
                        if (route.settings.name == RouteNames.mainPage) {
                          return true;
                        }
                        return false;
                      });
                    }
                  });
                },
              ),
            ),
            Visibility(
              visible: checkoutResponseModel.myFatoorahStatus!.status == 1
                  ? true
                  : false,
              child: PaymentCard(
                title: "Pay With MyFatoorah",
                icon: Kimages.myFatoorahIcon,
                press: () async {
                  String params =
                      "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}&request_from=flutter_app";
                  final token = context.read<LoginBloc>().userInfo!.accessToken;
                  Navigator.pushNamed(
                          context, RouteNames.myFatoorahPaymentScreen,
                          arguments:
                              RemoteUrls.payWithMyFatooraheWeb(token, params))
                      .then((value) {
                    if (value == true) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteNames.orderScreen, (route) {
                        if (route.settings.name == RouteNames.mainPage) {
                          return true;
                        }
                        return false;
                      });
                    }
                  });
                },
              ),
            ),
            Visibility(
              visible: checkoutResponseModel.instamojoStatus!.status == 1
                  ? true
                  : false,
              child: PaymentCard(
                title: "Pay With InstaMojo",
                icon: Kimages.instamojoIcon,
                press: () {
                  String params =
                      "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}&request_from=flutter_app";
                  final token = context.read<LoginBloc>().userInfo!.accessToken;
                  // debugPrint(RemoteUrls.razorOrder(token, params));
                  Navigator.pushNamed(
                      context, RouteNames.instamojoPaymentScreen,
                      arguments: RemoteUrls.payWithInstaMojoWeb(token, params));
                },
              ),
            ),
            Visibility(
              visible:
                  checkoutResponseModel.payStackMolliStatus!.payStackStatus == 1
                      ? true
                      : false,
              child: PaymentCard(
                title: "Pay With PayStack",
                icon: Kimages.paystackIcon,
                press: () {
                  String params =
                      "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}&request_from=flutter_app";
                  final token = context.read<LoginBloc>().userInfo!.accessToken;
                  // debugPrint(RemoteUrls.razorOrder(token, params));
                  Navigator.pushNamed(context, RouteNames.paystackPaymentScreen,
                      arguments: RemoteUrls.payWithPayStackWeb(token, params));
                },
              ),
            ),
            Visibility(
              visible: checkoutResponseModel.sslCommerzStatus!.status == 1
                  ? true
                  : false,
              child: PaymentCard(
                title: "Pay with Ssl-commerce",
                icon: Kimages.sslcommerz,
                press: () {
                  String params =
                      "shipping_method_id=${body['shipping_method_id']}&shipping_address_id=${body['shipping_address_id']}&billing_address_id=${body['billing_address_id']}&request_from=flutter_app";
                  final token = context.read<LoginBloc>().userInfo!.accessToken;
                  Navigator.pushNamed(context, RouteNames.sslCommerceScreen,
                      arguments: RemoteUrls.payWithSslCommerz(token, params));
                },
              ),
            ),
            Visibility(
              visible:
                  checkoutResponseModel.bankStatus!.cashOnDeliveryStatus == 1
                      ? true
                      : false,
              child: PaymentCard(
                title: Language.bankPayment,
                icon: Kimages.bankPayment,
                press: () {
                  Navigator.pushNamed(context, RouteNames.bankScreen,
                      arguments: body);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    Key? key,
    this.title,
    this.icon,
    this.press,
  }) : super(key: key);

  final String? title;
  final String? icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    // bool isPng = icon!.split(".").last.toString() == "png" ? true : false;
    return InkWell(
      onTap: press,
      child: Container(
        height: 70,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            color: deepGreenColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: deepGreenColor.withOpacity(0.5),
              width: 1,
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomImage(
                path: icon!,
              ),
            ),
            // const SizedBox(width: 8),
            // Expanded(
            //   flex: 3,
            //   child: Text(
            //     title!,
            //     style:
            //         const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            //   ),
            // ),

            const Icon(Icons.arrow_forward, color: textGreyColor),
          ],
        ),
      ),
    );
  }
}
