import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/utils/constants.dart';
import '/utils/language_string.dart';
import '/utils/utils.dart';
import '/widgets/primary_button.dart';
import '/widgets/rounded_app_bar.dart';
import '../../dummy_data/all_dummy_data.dart';
import '../authentication/widgets/sign_up_form.dart';
import 'component/delivery_man_identity_image.dart';
import 'component/delivery_man_image.dart';
import 'controller/delivery_man_cubit.dart';
import 'controller/delivery_man_state_model.dart';

class DeliveryManRegistrationScreen extends StatelessWidget {
  const DeliveryManRegistrationScreen({Key? key}) : super(key: key);
  final double space = 20.0;

  @override
  Widget build(BuildContext context) {
    final manCubit = context.read<DeliveryManCubit>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Delivery Man Register'),
      body: BlocListener<DeliveryManCubit, DeliveryManStateModel>(
        listener: (context, state) {
          final man = state.deliveryState;
          if (man is DeliveryManLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (man is DeliveryManError) {
              Utils.errorSnackBar(context, man.message);
            } else if (man is DeliveryManCreated) {
              Navigator.of(context).pop(true);
              Utils.showSnackBar(context, man.message);
              manCubit.clearState();
            }
          }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          physics: const BouncingScrollPhysics(),
          children: [
            const DeliveryManImage(),
            const DeliveryManIdentityImage(),
            BlocBuilder<DeliveryManCubit, DeliveryManStateModel>(
              builder: (context, state) {
                final man = state.deliveryState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: state.firstName,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                      onChanged: (String text) =>
                          manCubit.changeFirstName(text),
                    ),
                    if (man is DeliveryManFieldError) ...[
                      if (man.errors.firstName.isNotEmpty)
                        ErrorText(text: man.errors.firstName.first)
                    ],
                  ],
                );
              },
            ),
            Utils.verticalSpace(space),
            BlocBuilder<DeliveryManCubit, DeliveryManStateModel>(
              builder: (context, state) {
                final man = state.deliveryState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: state.lastName,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                      onChanged: (String text) => manCubit.changeLastName(text),
                    ),
                    if (man is DeliveryManFieldError) ...[
                      if (man.errors.lastName.isNotEmpty)
                        ErrorText(text: man.errors.lastName.first)
                    ],
                  ],
                );
              },
            ),
            Utils.verticalSpace(space),
            BlocBuilder<DeliveryManCubit, DeliveryManStateModel>(
              builder: (context, state) {
                final man = state.deliveryState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: state.email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: Language.email,
                      ),
                      onChanged: (String text) => manCubit.changeEmail(text),
                    ),
                    if (man is DeliveryManFieldError) ...[
                      if (man.errors.email.isNotEmpty)
                        ErrorText(text: man.errors.email.first)
                    ],
                  ],
                );
              },
            ),
            Utils.verticalSpace(space),
            BlocBuilder<DeliveryManCubit, DeliveryManStateModel>(
              builder: (context, state) {
                final man = state.deliveryState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: state.phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: Language.phoneNumber,
                      ),
                      onChanged: (String text) => manCubit.changePhone(text),
                    ),
                    if (man is DeliveryManFieldError) ...[
                      if (man.errors.phone.isNotEmpty)
                        ErrorText(text: man.errors.phone.first)
                    ],
                  ],
                );
              },
            ),
            Utils.verticalSpace(space),
            BlocBuilder<DeliveryManCubit, DeliveryManStateModel>(
              builder: (context, state) {
                final man = state.deliveryState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: state.idnNumber,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Identity Number',
                      ),
                      onChanged: (String text) =>
                          manCubit.changeIdnNumber(text),
                    ),
                    if (man is DeliveryManFieldError) ...[
                      if (man.errors.idnNumber.isNotEmpty)
                        ErrorText(text: man.errors.idnNumber.first)
                    ],
                  ],
                );
              },
            ),
            Utils.verticalSpace(space),
            BlocBuilder<DeliveryManCubit, DeliveryManStateModel>(
              builder: (context, state) {
                final man = state.deliveryState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<IdentityType>(
                      hint: const Text('Identity Type'),
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onChanged: (value) {
                        if (value == null) return;
                        final title = value.title.toLowerCase();
                        print(title);
                        manCubit.changeManType(title);
                      },
                      isDense: true,
                      isExpanded: true,
                      items: identityType.map<DropdownMenuItem<IdentityType>>(
                          (IdentityType value) {
                        return DropdownMenuItem<IdentityType>(
                            value: value, child: Text(value.title));
                      }).toList(),
                    ),
                    if (man is DeliveryManFieldError) ...[
                      if (man.errors.idnType.isNotEmpty)
                        ErrorText(text: man.errors.idnType.first)
                    ],
                  ],
                );
              },
            ),
            Utils.verticalSpace(space),
            BlocBuilder<DeliveryManCubit, DeliveryManStateModel>(
              builder: (context, state) {
                final man = state.deliveryState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<IdentityType>(
                      hint: const Text('Man Type'),
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      onChanged: (value) {
                        if (value == null) return;
                        final title = value.title.toLowerCase();
                        print(title);
                        manCubit.changeIdnType(title);
                      },
                      isDense: true,
                      isExpanded: true,
                      items: manType.map<DropdownMenuItem<IdentityType>>(
                          (IdentityType value) {
                        return DropdownMenuItem<IdentityType>(
                            value: value, child: Text(value.title));
                      }).toList(),
                    ),
                    if (man is DeliveryManFieldError) ...[
                      if (man.errors.manType.isNotEmpty)
                        ErrorText(text: man.errors.manType.first)
                    ],
                  ],
                );
              },
            ),
            Utils.verticalSpace(space),
            BlocBuilder<DeliveryManCubit, DeliveryManStateModel>(
              builder: (context, state) {
                final man = state.deliveryState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: state.password,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: Language.password,
                          suffixIcon: GestureDetector(
                            onTap: () =>
                                manCubit.showPassword(state.showPassword!),
                            child: Icon(
                              state.showPassword!
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: grayColor,
                              size: 22.0,
                            ),
                          )),
                      onChanged: (String text) => manCubit.changePassword(text),
                      obscureText: state.showPassword!,
                    ),
                    if (man is DeliveryManFieldError) ...[
                      if (man.errors.password.isNotEmpty)
                        ErrorText(text: man.errors.password.first)
                    ],
                  ],
                );
              },
            ),
            Utils.verticalSpace(space),
            BlocBuilder<DeliveryManCubit, DeliveryManStateModel>(
              builder: (context, state) {
                final man = state.deliveryState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: state.confirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: Language.confirmPassword,
                          suffixIcon: GestureDetector(
                            onTap: () => manCubit.showConfirmPassword(
                                state.showConfirmPassword!),
                            child: Icon(
                              state.showConfirmPassword!
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: grayColor,
                              size: 22.0,
                            ),
                          )),
                      onChanged: (String text) =>
                          manCubit.changeConfirmPassword(text),
                      obscureText: state.showConfirmPassword!,
                    ),
                    if (man is DeliveryManFieldError) ...[
                      if (state.password.isNotEmpty)
                        if (man.errors.confirmPassword.isNotEmpty)
                          ErrorText(text: man.errors.confirmPassword.first)
                    ],
                  ],
                );
              },
            ),
            Utils.verticalSpace(space),
            PrimaryButton(
                text: 'Create Delivery Man',
                onPressed: () {
                  Utils.closeKeyBoard(context);
                  manCubit.createDeliveryMan();
                }),
            Utils.verticalSpace(size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
