import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '/widgets/capitalized_word.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/primary_button.dart';
import '../../utils/k_images.dart';
import '../../utils/language_string.dart';
import '../../widgets/custom_image.dart';
import 'controller/login/login_bloc.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  bool _isValid = false;
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomRight,
              colors: [Colors.white, Color(0xffFFEFE7)],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(child: _buildForm()),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CircleAvatar(
          radius: 96,
          child: const CustomImage(path: Kimages.forgotIcon),
          backgroundColor: redColor.withOpacity(0.1),
        ),
        const SizedBox(height: 55),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Language.verificationCode.capitalizeByWord(),
            style: GoogleFonts.poppins(
                height: 1, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 22),
        Pinput(
          controller: pinController,
          defaultPinTheme: PinTheme(
            height: 52,
            width: 52,
            textStyle: GoogleFonts.poppins(fontSize: 26, color: blackColor),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          autofocus: true,
          keyboardType: TextInputType.number,
          length: 6,
          validator: (String? s) {
            if (s == null || s.isEmpty)
              return Language.enterCode.capitalizeByWord();
            return null;
          },
          onChanged: (String s) {
            if (s.length == 6) {
              _isValid = true;
            } else {
              _isValid = false;
            }
            setState(() {});
          },
          onCompleted: (String s) {
            log('onComplete');
            context.read<LoginBloc>().add(AccountActivateCodeSubmit(s));
          },
          onSubmitted: (String s) {
            log('onSUbmit');
          },
          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
        ),
        const SizedBox(height: 28),
        BlocBuilder<LoginBloc, LoginModelState>(
          builder: (context, state) {
            if (state.state is LoginStateLoading) {
              return const CircularProgressIndicator();
            }
            return _buildContinueBtn();
          },
        ),
        const SizedBox(height: 15),
        Text.rich(
          TextSpan(
            text: '${Language.dontReceivedCode} ? ',
            style: const TextStyle(color: Color(0xff878D97)),
            children: [
              TextSpan(
                text: Language.resend.capitalizeByWord(),
                style: const TextStyle(color: Color(0xff000000)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContinueBtn() {
    return PrimaryButton(
      // text: Language.continue,
      text: 'Continue',
      // grediantColor: _isValid
      //     ? greenGredient
      //     : [
      //         lightningYellowColor.withOpacity(.6),
      //         lightningYellowColor.withOpacity(.6),
      //       ],
      onPressed: _isValid
          ? () {
              context
                  .read<LoginBloc>()
                  .add(AccountActivateCodeSubmit(pinController.text));
            }
          : null,
    );
  }
}
