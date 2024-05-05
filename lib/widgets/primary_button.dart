import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key? key,
    this.maximumSize = const Size(double.infinity, 52),
    required this.text,
    //this.grediantColor = greenGredient,
    this.fontSize = 14,
    required this.onPressed,
    this.minimumSize = const Size(double.infinity, 52),
    this.borderRadiusSize = 0,
    this.bgColor = redColor,
  }) : super(key: key);

  final VoidCallback? onPressed;

  //final List<Color> grediantColor;
  final String text;
  final Size maximumSize;
  final Size minimumSize;
  final double fontSize;
  final double borderRadiusSize;
  Color bgColor;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(borderRadiusSize);
    bgColor = Utils.dynamicPrimaryColor(context);
    return Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: grediantColor,
        // ),
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        // style: ElevatedButton.styleFrom(
        //   shape: RoundedRectangleBorder(borderRadius: borderRadius),
        //   backgroundColor: Colors.transparent,
        //   minimumSize: minimumSize,
        //   maximumSize: maximumSize,
        //   shadowColor: Colors.transparent,
        // ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: borderRadius)),
          backgroundColor: MaterialStateProperty.all(bgColor),
          elevation: MaterialStateProperty.all(0.0),
          minimumSize: MaterialStateProperty.all(minimumSize),
          maximumSize: MaterialStateProperty.all(maximumSize),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
        ),
        child: Text(
          text,
          style: TextStyle(
              color: buttonTextColor,
              fontSize: fontSize,
              height: 1.5,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  SocialButton({
    Key? key,
    this.maximumSize = const Size(double.infinity, 52),
    required this.text,
    //this.grediantColor = greenGredient,
    required this.icon,
    this.fontSize = 14,
    required this.onPressed,
    this.minimumSize = const Size(double.infinity, 52),
    this.borderRadiusSize = 0,
    this.bgColor = redColor,
    this.textColor = redColor,
  }) : super(key: key);

  final VoidCallback? onPressed;

  //final List<Color> grediantColor;
  final String text;
  final String icon;
  final Size maximumSize;
  final Size minimumSize;
  final double fontSize;
  final double borderRadiusSize;
  Color bgColor;
  Color textColor;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(borderRadiusSize);
    return Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: grediantColor,
        // ),
        border: Border.all(color: primaryColor),
        borderRadius: borderRadius,
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        // style: ElevatedButton.styleFrom(
        //   shape: RoundedRectangleBorder(borderRadius: borderRadius),
        //   backgroundColor: Colors.transparent,
        //   minimumSize: minimumSize,
        //   maximumSize: maximumSize,
        //   shadowColor: Colors.transparent,
        // ),
        icon: SvgPicture.asset(icon, height: 20),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: borderRadius)),
          backgroundColor: MaterialStateProperty.all(bgColor),
          elevation: MaterialStateProperty.all(0.0),
          minimumSize: MaterialStateProperty.all(minimumSize),
          maximumSize: MaterialStateProperty.all(maximumSize),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
        ),
        label: Text(
          text,
          style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              height: 1.5,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

