import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'primary_button.dart';
import '../utils/constants.dart';

class FeedbackSuccess extends StatelessWidget {
  const FeedbackSuccess({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/feedback_success.svg"),
          const SizedBox(height: 60),
          const Text(
            "Thanks for your valuable\n Feedback",
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 1.3, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            "Thanks you for your help and quick\ndelivery which enable",
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 1.3,
                fontSize: 16,
                color: iconGreyColor,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 190,
            child: PrimaryButton(
              text: 'Go to Home',
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
