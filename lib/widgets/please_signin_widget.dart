import 'package:flutter/material.dart';

import '../core/router_name.dart';
import '../utils/constants.dart';
import 'primary_button.dart';

class PleaseSigninWidget extends StatelessWidget {
  const PleaseSigninWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign in please",
                style: TextStyle(color: redColor),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                text: 'Signin',
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.authenticationScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
