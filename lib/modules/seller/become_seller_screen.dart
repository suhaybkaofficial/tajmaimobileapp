import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/authentication/widgets/sign_up_form.dart';
import '/modules/seller/component/banner_image.dart';
import '/modules/seller/component/logo_image.dart';
import '/modules/seller/controller/become_seller_cubit.dart';
import '/modules/seller/controller/become_seller_state_model.dart';
import '/utils/language_string.dart';
import '/widgets/rounded_app_bar.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';

class BecomeSellerScreen extends StatelessWidget {
  const BecomeSellerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 20.0);
    final sellerCubit = context.read<BecomeSellerCubit>();
    return Scaffold(
      appBar: RoundedAppBar(titleText: Language.becomeSeller),
      body: BlocListener<BecomeSellerCubit, BecomeSellerStateModel>(
        listener: (context, state) {
          final seller = state.sellerState;
          if (seller is BecomeSellerAgreeError) {
            Utils.errorSnackBar(context, seller.message);
          } else if (seller is BecomeSellerError) {
            Utils.errorSnackBar(context, seller.message);
          } else if (seller is BecomeSellerLoaded) {
            Navigator.of(context).pop(true);
            Utils.showSnackBar(context, seller.message);
          }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            const BannerImage(),
            //spacer,
            const LogoImage(),
            // spacer,
            BlocBuilder<BecomeSellerCubit, BecomeSellerStateModel>(
                builder: (context, state) {
              final seller = state.sellerState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: state.shopName,
                    decoration: InputDecoration(
                      hintText: Language.shopName,
                    ),
                    onChanged: (String value) =>
                        sellerCubit.shopNameChange(value),
                    keyboardType: TextInputType.name,
                  ),
                  if (seller is BecomeSellerFormValidate) ...[
                    if (seller.error.shopName.isNotEmpty)
                      ErrorText(text: seller.error.shopName.first),
                  ]
                ],
              );
            }),
            spacer,
            BlocBuilder<BecomeSellerCubit, BecomeSellerStateModel>(
                builder: (context, state) {
              final seller = state.sellerState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: state.email,
                    decoration: InputDecoration(
                      hintText: Language.emailAddress,
                    ),
                    onChanged: (String value) => sellerCubit.emailChange(value),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  if (seller is BecomeSellerFormValidate) ...[
                    if (seller.error.email.isNotEmpty)
                      ErrorText(text: seller.error.email.first),
                  ]
                ],
              );
            }),
            spacer,
            BlocBuilder<BecomeSellerCubit, BecomeSellerStateModel>(
                builder: (context, state) {
              final seller = state.sellerState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: state.phone,
                    decoration: InputDecoration(
                      hintText: Language.phoneNumber,
                    ),
                    onChanged: (String value) => sellerCubit.phoneChange(value),
                    keyboardType: TextInputType.phone,
                  ),
                  if (seller is BecomeSellerFormValidate) ...[
                    if (seller.error.phone.isNotEmpty)
                      ErrorText(text: seller.error.phone.first),
                  ]
                ],
              );
            }),
            spacer,
            BlocBuilder<BecomeSellerCubit, BecomeSellerStateModel>(
                builder: (context, state) {
              final seller = state.sellerState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: state.address,
                    decoration: InputDecoration(
                      hintText: Language.address,
                    ),
                    onChanged: (String value) =>
                        sellerCubit.addressChange(value),
                    keyboardType: TextInputType.streetAddress,
                  ),
                  if (seller is BecomeSellerFormValidate) ...[
                    if (seller.error.address.isNotEmpty)
                      ErrorText(text: seller.error.address.first),
                  ]
                ],
              );
            }),
            spacer,
            BlocBuilder<BecomeSellerCubit, BecomeSellerStateModel>(
                builder: (context, state) {
              final seller = state.sellerState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: state.openAt,
                    decoration: const InputDecoration(
                      hintText: 'Open At',
                    ),
                    onChanged: (String value) =>
                        sellerCubit.openAtChange(value),
                    keyboardType: TextInputType.datetime,
                  ),
                  if (seller is BecomeSellerFormValidate) ...[
                    if (seller.error.openAt.isNotEmpty)
                      ErrorText(text: seller.error.openAt.first),
                  ]
                ],
              );
            }),
            spacer,
            BlocBuilder<BecomeSellerCubit, BecomeSellerStateModel>(
                builder: (context, state) {
              final seller = state.sellerState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: state.closeAt,
                    decoration: const InputDecoration(
                      hintText: 'Closed At',
                    ),
                    onChanged: (String value) =>
                        sellerCubit.closeAtChange(value),
                    keyboardType: TextInputType.datetime,
                  ),
                  if (seller is BecomeSellerFormValidate) ...[
                    if (seller.error.closedAt.isNotEmpty)
                      ErrorText(text: seller.error.closedAt.first),
                  ]
                ],
              );
            }),
            spacer,
            _buildRememberMe(),
            spacer,
            BlocBuilder<BecomeSellerCubit, BecomeSellerStateModel>(
              builder: (context, state) {
                final seller = state.sellerState;
                if (seller is BecomeSellerLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return PrimaryButton(
                  text: 'Become Seller Request',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    sellerCubit.becomeSellerRequest();
                    // bloc.add(SignUpEventSubmit());
                  },
                );
              },
            ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }

  Widget _buildRememberMe() {
    return BlocBuilder<BecomeSellerCubit, BecomeSellerStateModel>(
      buildWhen: (previous, current) =>
          previous.agreeTermsAndCondition != current.agreeTermsAndCondition,
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              value: state.agreeTermsAndCondition == '1',
              checkColor: Colors.white,
              activeColor: Utils.dynamicPrimaryColor(context),
              onChanged: (v) {
                if (v == null) return;
                context
                    .read<BecomeSellerCubit>()
                    .conditionChange(v ? '1' : '0');
                //context.read<BecomeSellerCubit>().add(SignUpEventAgree(v ? 1 : 0));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                'Agree Terms & Condition',
                style: TextStyle(color: blackColor.withOpacity(.5)),
              ),
            )
          ],
        );
      },
    );
  }
}
