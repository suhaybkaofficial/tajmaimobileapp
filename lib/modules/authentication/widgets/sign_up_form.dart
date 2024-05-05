import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/widgets/capitalized_word.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/primary_button.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../controller/sign_up/sign_up_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignUpBloc>();
    final appSettingBloc =
        context.read<AppSettingCubit>().settingModel!.setting;
    //print('phoneCode ${appSettingBloc.settingModel!.setting.defaultPhoneCode}');
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 12),
            BlocBuilder<SignUpBloc, SignUpModelState>(
              builder: (context, state) {
                final s = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      initialValue: state.name,
                      onChanged: (value) => bloc.add(SignUpEventName(value)),
                      decoration: InputDecoration(
                          hintText: Language.name.capitalizeByWord()),
                    ),
                    if (s is SignUpStateFormValidationError) ...[
                      if (s.errors.name.isNotEmpty)
                        ErrorText(text: s.errors.name.first),
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<SignUpBloc, SignUpModelState>(
              builder: (context, state) {
                final s = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      initialValue: state.email,
                      onChanged: (value) => bloc.add(SignUpEventEmail(value)),
                      decoration: InputDecoration(
                          hintText: Language.emailAddress.capitalizeByWord()),
                    ),
                    if (bloc.state.name.isNotEmpty)
                      if (s is SignUpStateFormValidationError) ...[
                        if (s.errors.email.isNotEmpty)
                          ErrorText(text: s.errors.email.first),
                      ]
                  ],
                );
              },
            ),
            if (appSettingBloc.phoneNumberRequired == 1) ...[
              const SizedBox(height: 16),
              BlocBuilder<SignUpBloc, SignUpModelState>(
                builder: (context, state) {
                  final s = state.state;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        initialValue: state.phone,
                        onChanged: (value) => bloc.add(SignUpEventPhone(value)),
                        decoration: InputDecoration(
                          hintText: Language.phoneNumber.capitalizeByWord(),
                          prefixIcon: CountryCodePicker(
                            padding: const EdgeInsets.only(bottom: 8),
                            onChanged: (country) {
                              bloc.add(
                                SignUpEventCountryCode(country.dialCode ?? ''),
                              );
                              // profileEdBlc
                              //     .changePhoneCode(country.dialCode ?? '');
                            },
                            flagWidth: 35,
                            initialSelection: appSettingBloc.defaultPhoneCode,
                            favorite: const ['+880', 'BD'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                          // hintText: Language.phoneNumber.capitalizeByWord(),
                        ),
                      ),
                      if (appSettingBloc.enableUserRegister == 1 &&
                          state.email.isNotEmpty)
                        if (s is SignUpStateFormValidationError) ...[
                          if (s.errors.phone.isNotEmpty)
                            ErrorText(text: s.errors.phone.first),
                        ]
                    ],
                  );
                },
              ),
            ],
            const SizedBox(height: 16),
            BlocBuilder<SignUpBloc, SignUpModelState>(
              builder: (context, state) {
                final s = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      initialValue: state.password,
                      onChanged: (value) =>
                          bloc.add(SignUpEventPassword(value)),
                      obscureText: state.showPassword,
                      decoration: InputDecoration(
                        hintText: Language.password.capitalizeByWord(),
                        suffixIcon: IconButton(
                            icon: Icon(
                              state.showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: grayColor,
                            ),
                            onPressed: () => bloc.add(
                                SignUpEventShowPassword(state.showPassword))),
                      ),
                    ),
                    if ((appSettingBloc.enableUserRegister == 1 ||
                            state.phone.isNotEmpty) &&
                        (state.email.isNotEmpty && state.password.isEmpty))
                      if (s is SignUpStateFormValidationError) ...[
                        if (s.errors.password.isNotEmpty)
                          ErrorText(text: s.errors.password.first),
                      ]
                  ],
                  // if (s is SignUpStateFormValidationError) ...[
                  //   if (s.errors.password.isNotEmpty)
                  //     ErrorText(text: s.errors.password.first),
                  // ]
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<SignUpBloc, SignUpModelState>(
              builder: (context, state) {
                final s = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      initialValue: state.passwordConfirmation,
                      onChanged: (value) =>
                          bloc.add(SignUpEventPasswordConfirm(value)),
                      obscureText: state.showConPassword,
                      decoration: InputDecoration(
                        hintText: Language.confirmPassword.capitalizeByWord(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            state.showConPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: grayColor,
                          ),
                          onPressed: () => bloc.add(SignUpEventShowConPassword(
                              state.showConPassword)),
                        ),
                      ),
                    ),
                    if (state.passwordConfirmation.isNotEmpty ||
                        (state.passwordConfirmation.isEmpty &&
                            !state.passwordConfirmation
                                .contains(state.password)))
                      if (s is SignUpStateFormValidationError) ...[
                        if (s.errors.password.isNotEmpty)
                          ErrorText(text: s.errors.password.first),
                      ]
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            _buildRememberMe(),
            const SizedBox(height: 25),
            BlocBuilder<SignUpBloc, SignUpModelState>(
              buildWhen: (previous, current) => previous.state != current.state,
              builder: (context, state) {
                if (state.state is SignUpStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return PrimaryButton(
                  text: Language.singUp.capitalizeByWord(),
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    bloc.add(SignUpEventSubmit());
                  },
                );
              },
            ),
            // const SizedBox(height: 28),
            // const GuestButton(),
            SizedBox(height: size.height * 0.2),
          ],
        ),
      ),
    );
  }

  Widget _buildRememberMe() {
    return BlocBuilder<SignUpBloc, SignUpModelState>(
      buildWhen: (previous, current) => previous.agree != current.agree,
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              value: state.agree == 1,
              checkColor: Colors.white,
              activeColor: Utils.dynamicPrimaryColor(context),
              onChanged: (v) {
                if (v == null) return;
                context.read<SignUpBloc>().add(SignUpEventAgree(v ? 1 : 0));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                Language.signUpCondition.capitalizeByWord(),
                style: TextStyle(color: blackColor.withOpacity(.5)),
              ),
            )
          ],
        );
      },
    );
  }
}

class ErrorText extends StatelessWidget {
  const ErrorText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.caption!.copyWith(
              color: Colors.red,
            ),
      ),
    );
  }
}
