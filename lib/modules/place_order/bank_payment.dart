import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_o/modules/authentication/widgets/sign_up_form.dart';

import '/utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';
import '../cart/controllers/checkout/checkout_cubit.dart';
import 'controllers/bank/bank_cubit.dart';

class BankPaymentScreen extends StatefulWidget {
  const BankPaymentScreen({Key? key, required this.mapBody}) : super(key: key);
  final Map<String, dynamic> mapBody;

  @override
  State<BankPaymentScreen> createState() => _BankPaymentScreenState();
}

class _BankPaymentScreenState extends State<BankPaymentScreen> {
  final formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bankInfo = context.read<CheckoutCubit>().checkoutResponseModel;
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Bank Payment'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          shrinkWrap: true,
          children: [
            BlocBuilder<BankCubit, BankState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      maxLines: 10,
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: bankInfo!.bankStatus!.accountInfo,
                      ),
                    ),
                    if (state is BankPaymentFormError) ...[
                      if (state.errors.tnxInfo.isNotEmpty)
                        ErrorText(text: state.errors.tnxInfo.first),
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              onPressed: () {
                final Map<String, String> body = {
                  'agree_terms_condition': '1',
                  'shipping_address_id': widget.mapBody['shipping_address_id'],
                  'billing_address_id': widget.mapBody['billing_address_id'],
                  'shipping_method_id': widget.mapBody['shipping_method_id'],
                  'tnx_info': textController.text
                };
                debugPrint(body.toString());
                Utils.closeKeyBoard(context);
                context.read<BankCubit>().makeBankPayment(body);
              },
              text: "Continue",
            )
          ],
        ),
      ),
    );
  }
}
