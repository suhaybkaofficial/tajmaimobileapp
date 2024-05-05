import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_o/utils/language_string.dart';
import 'package:shop_o/widgets/capitalized_word.dart';

import '../utils/constants.dart';
import 'custom_image.dart';

class ActionDialog extends StatelessWidget {
  const ActionDialog(
      {Key? key,
      required this.title,
      required this.image,
      required this.onTap,
      this.iconSize = 100.0,
      this.color = redColor,
      this.bgColor = redColor,
      this.textColor = redColor,
      required this.deleteText,
      this.textSize = 18.0})
      : super(key: key);
  final String image;
  final String title;
  final String deleteText;
  final double textSize;
  final double iconSize;
  final Color color;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 300.0,
        width: 340.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xFFFFFFFF),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30.0),
            SizedBox(
                height: iconSize,
                width: iconSize,
                child: CustomImage(
                  path: image,
                  color: color,
                  // fit: BoxFit.cover,
                )),
            const SizedBox(height: 30.0),
            Text(
              // 'Are You sure,you want to Exit?',
              title,
              style: GoogleFonts.roboto(
                  fontSize: textSize,
                  color: blackColor,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                dialogButton(
                    Language.cancel.capitalizeByWord(),
                    () => Navigator.of(context).pop(),
                    blackColor,
                    primaryColor),
                dialogButton(deleteText, onTap, bgColor, textColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget dialogButton(String text, VoidCallback onTap, Color bgColor, textColor) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 40.0,
      width: 100.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(4.0)),
      child: Text(
        text,
        style: GoogleFonts.roboto(
            fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    ),
  );
}
