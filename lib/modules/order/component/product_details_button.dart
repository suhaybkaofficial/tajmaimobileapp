import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ProductDetailsButton extends StatelessWidget {
  const ProductDetailsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: redColor),
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Text(
          'Details',
          style: TextStyle(fontSize: 12, color: redColor),
        ),
      ),
    );
  }
}
