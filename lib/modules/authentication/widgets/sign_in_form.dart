import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/authentication/widgets/sign_up_form.dart';
import '/widgets/capitalized_word.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../controller/login/login_bloc.dart';
import 'guest_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: loginBloc.formKey,
        child: Column(
          children: [
            const SizedBox(height: 12),
            BlocBuilder<LoginBloc, LoginModelState>(
              builder: (context, state) {
                final login = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      initialValue: state.text,
                      onChanged: (value) =>
                          loginBloc.add(LoginEvenEmailOrPhone(value)),
                      decoration: InputDecoration(
                        hintText: Language.emailOrPhone,
                      ),
                    ),
                    if (login is LoginStateFormInvalid) ...[
                      if (login.error.email.isNotEmpty)
                        ErrorText(text: login.error.email.first)
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<LoginBloc, LoginModelState>(
              builder: (context, state) {
                final login = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      initialValue: state.password,
                      onChanged: (value) =>
                          loginBloc.add(LoginEventPassword(value)),
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
                          onPressed: () => loginBloc
                              .add(ShowPasswordEvent(state.showPassword)),
                        ),
                      ),
                    ),
                    if (state.text != '')
                      if (login is LoginStateFormInvalid) ...[
                        if (login.error.password.isNotEmpty)
                          ErrorText(text: login.error.password.first)
                      ]
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            _buildRememberMe(),
            const SizedBox(height: 25),
            BlocBuilder<LoginBloc, LoginModelState>(
              buildWhen: (previous, current) => previous.state != current.state,
              builder: (context, state) {
                if (state.state is LoginStateLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return PrimaryButton(
                  text: Language.login.capitalizeByWord(),
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    loginBloc.add(const LoginEventSubmit());
                  },
                );
              },
            ),
            const SizedBox(height: 50),
            // Row(
            //   // mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Expanded(
            //       child: Container(
            //         color: textGreyColor,
            //         width: double.infinity,
            //         height: 1,
            //         margin: const EdgeInsets.symmetric(horizontal: 10),
            //       ),
            //     ),
            //     const Text(
            //       "OR",
            //       style: TextStyle(
            //           color: textGreyColor,
            //           fontSize: 16,
            //           height: 1.5,
            //           fontWeight: FontWeight.w500),
            //     ),
            //     Expanded(
            //       child: Container(
            //         color: textGreyColor,
            //         width: double.infinity,
            //         height: 1,
            //         margin: const EdgeInsets.symmetric(horizontal: 10),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 25),
            // BlocBuilder<LoginBloc, LoginModelState>(
            //   buildWhen: (previous, current) => previous.state != current.state,
            //   builder: (context, state) {
            //     if (state.state is GoogleStateLoading) {
            //       return const Center(child: CircularProgressIndicator());
            //     }
            //     return SocialButton(
            //       text: "Continue with Google",
            //       bgColor: Colors.white,
            //       textColor: Colors.black,
            //       icon: Kimages.google,
            //       onPressed: () {
            //         Utils.closeKeyBoard(context);
            //         loginBloc.add(const GoogleSignInEvent());
            //       },
            //     );
            //   },
            // ),
            // const SizedBox(height: 25),
            // BlocBuilder<LoginBloc, LoginModelState>(
            //   buildWhen: (previous, current) => previous.state != current.state,
            //   builder: (context, state) {
            //     if (state.state is FacebookStateLoading) {
            //       return const Center(child: CircularProgressIndicator());
            //     }
            //     return SocialButton(
            //       text: "Continue with Facebook",
            //       bgColor: Colors.blueAccent,
            //       textColor: Colors.white,
            //       icon: Kimages.facebook,
            //       onPressed: () {
            //         // Utils.closeKeyBoard(context);
            //         // loginBloc.add(const FacebookSignInEvent());
            //         Utils.showSnackBar(
            //             context, "Facebook login need further configuration");
            //       },
            //     );
            //   },
            // ),
            //const SizedBox(height: 28),
            const GuestButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRememberMe() {
    final loginBloc = context.read<LoginBloc>();
    return BlocBuilder<LoginBloc, LoginModelState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: state.rememberMe,
                  checkColor: Colors.white,
                  activeColor: Utils.dynamicPrimaryColor(context),
                  onChanged: (val) {
                    loginBloc.add(RememberMeEvent(state.rememberMe));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    Language.rememberMe.capitalizeByWord(),
                    style: TextStyle(color: blackColor.withOpacity(.5)),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.forgotScreen);
              },
              child: Text(
                '${Language.forgotPassword.capitalizeByWord()}?',
                style: TextStyle(color: Utils.dynamicPrimaryColor(context)),
              ),
            ),
          ],
        );
      },
    );
  }
}
