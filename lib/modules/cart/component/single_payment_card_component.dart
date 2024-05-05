import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../widgets/custom_radio_button.dart';

class SinglePaymentCardComponent extends StatelessWidget {
  const SinglePaymentCardComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: borderColor)),
      child: ListTile(
        horizontalTitleGap: 0,
        leading: const CustomRadioButton(isSelected: true),
        title: Row(
          children: const [
            Icon(Icons.paypal_outlined),
            SizedBox(width: 10),
            Flexible(
              child: Text("MasterCard", maxLines: 1),
            ),
          ],
        ),
        subtitle: const Text('874 ****** 8372'),
        trailing: const CircleAvatar(
          backgroundColor: Color(0xffC1D4DF),
          radius: 13,
          child: Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: blackColor),
        ),
      ),
    );
  }
}
