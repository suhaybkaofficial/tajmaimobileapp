import 'package:flutter/material.dart';

// Color primaryColor = const Color(0xFFFFFCF7);
Color primaryColor = const Color(0xFFFFF7FC);
const Color blackColor = Color(0xff0B2C3D);
const Color buttonTextColor = Color(0xff1D1D1D);
const Color borderColor = Color(0xFFF0F0F0);
// const Color borderColor = Color(0xFFFFEBC4);
const Color greenColor = Color(0xFF34A853);
const Color redColor = Color(0xFFEF262C);
const Color deepGreenColor = Color(0xFF27AE60);
final Color grayColor = const Color(0xff0B2C3D).withOpacity(.3);
// const Color lightningYellowColor = Color(0xffFFBB38);
const Color iconGreyColor = Color(0xff85959E);
const Color paragraphColor = Color(0xff18587A);
const Color appBgColor = Color(0xffFFFCF7);
const Color cardBgGreyColor = Color(0xffEDF1F3);
const Color textGreyColor = Color(0xff797979);
const Color inputFieldBgColor = Color(0xffFFFCF7);
const Color grayBorderColor = Color(0xffE8E8E8);
//const greenGredient = [lightningYellowColor, lightningYellowColor];

// #duration
const kDuration = Duration(milliseconds: 300);

final _borderRadius = BorderRadius.circular(4);

var inputDecorationTheme = InputDecoration(
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  hintStyle: const TextStyle(fontSize: 18, height: 1.667),
  border: OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: const BorderSide(color: Colors.white),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: const BorderSide(color: Colors.white),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: _borderRadius,
    borderSide: const BorderSide(color: Colors.white),
  ),
  fillColor: primaryColor,
  filled: true,
  focusColor: primaryColor,
);

final gredientColors = [
  [const Color(0xffF6290C), const Color(0xffC70F16)],
  [const Color(0xff019BFE), const Color(0xff0077C1)],
  [const Color(0xff161632), const Color(0xff3D364E)],
  [const Color(0xffF6290C), const Color(0xffC70F16)],
  [const Color(0xff019BFE), const Color(0xff0077C1)],
  [const Color(0xff161632), const Color(0xff3D364E)],
];
