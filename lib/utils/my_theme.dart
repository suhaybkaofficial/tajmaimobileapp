import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class MyTheme {
  static final borderRadius = BorderRadius.circular(0);
  static Color dynamicColor = Color(0xFFffbb38);

//Utils.dynamicPrimaryColor(context)

  static theme(BuildContext context) => ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        // bottomSheetTheme: const BottomSheetThemeData(backgroundColor: primaryColor),
        // colorScheme:
        //     ColorScheme.light(secondary: Utils.dynamicPrimaryColor(context)),
        colorScheme: ColorScheme.light(secondary: primaryColor),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          centerTitle: true,
          titleTextStyle: const TextStyle(
              color: blackColor, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: const IconThemeData(color: blackColor),
          elevation: 0,
        ),
        textTheme: GoogleFonts.interTextTheme(
          const TextTheme(
            caption: TextStyle(fontSize: 12, height: 1.83),
            bodyText1: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, height: 1.375),
            bodyText2: TextStyle(fontSize: 14, height: 1.5714),
            button:
                TextStyle(fontSize: 16, height: 2, fontWeight: FontWeight.w600),
            // titleLarge: const TextStyle(
            //     fontSize: 16, height: 2, fontWeight: FontWeight.w600),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 64),
            backgroundColor: dynamicColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 3,
          backgroundColor: const Color(0x00ffffff),
          selectedLabelStyle: TextStyle(color: dynamicColor, fontSize: 14.0),
          unselectedLabelStyle:
              const TextStyle(color: paragraphColor, fontSize: 12.0),
          selectedItemColor: dynamicColor,
          unselectedItemColor: paragraphColor,
          showUnselectedLabels: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          hintStyle: TextStyle(color: grayColor),
          labelStyle: TextStyle(color: grayColor, fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: dynamicColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(color: borderColor),
          ),
          fillColor: inputFieldBgColor,
          filled: true,
          focusColor: inputFieldBgColor,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: blackColor,
          selectionColor: blackColor,
          selectionHandleColor: blackColor,
        ),
      );
}
