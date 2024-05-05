import 'dart:developer';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../model/transaction_response.dart';

class PaymentService {
  static Future<TransactionResponse> paymentSheet(
      Map<String, dynamic> paymentIntentData) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // testEnv: true,
          // merchantCountryCode: 'US',
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData['customer'],
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      final result = await Stripe.instance.retrievePaymentIntent(
        paymentIntentData['client_secret'],
      );

      log(result.id.toString(), name: "result");

      if (result.status.name == "Succeeded") {
        return TransactionResponse(
          message: "Payment Succcessful",
          stripeToken: result.id,
          success: true,
        );
      } else {
        return const TransactionResponse(
          message: "Payment Failed",
          success: false,
        );
      }
    } catch (e) {
      if (e is StripeException) {
        log(e.toString(), name: "PaymentService");
        return const TransactionResponse(
          message: "Payment Failed",
          success: false,
        );
      } else {
        return const TransactionResponse(
          message: "Payment Failed",
          success: false,
        );
      }
    }
  }
}
