
import 'package:flutter/material.dart';

class CustomCircularCountDownProgress extends StatelessWidget {
  const CustomCircularCountDownProgress({
    Key? key,
    required this.value,
    required this.title,
    required this.maxValue,
    required this.color,
  })  : assert(maxValue > value, "maxValue must be greter then value"),
        super(key: key);
  final int value;
  final String title;
  final int maxValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // double percent = 1 - (value / maxValue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Center(
            child: Text(
              "$value",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  height: 1,
                  color: color),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1,
              color: Colors.black),
        ),
      ],
    );
  }
}