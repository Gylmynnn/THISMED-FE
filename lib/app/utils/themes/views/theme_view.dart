import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeUtilsView {
  static ThemeData getLightTheme() {
    return ThemeData(
        colorScheme: const ColorScheme.light(primary: Colors.black),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
        ),
        brightness: Brightness.light,
        primaryTextTheme: GoogleFonts.poppinsTextTheme());
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
        colorScheme: const ColorScheme.dark(primary: Colors.white),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
        ),
        brightness: Brightness.dark,
        textTheme: GoogleFonts.poppinsTextTheme());
  }

  static Transition getDefaultTransition(String value) {
    switch (value) {
      case 'Fade':
        return Transition.fade;
      case 'Zoom':
        return Transition.zoom;
      case 'RightToLeft':
        return Transition.rightToLeft;
      case 'UpToDown':
        return Transition.upToDown;
      case 'DownToUp':
        return Transition.downToUp;
      case 'FadeIn':
        return Transition.fadeIn;
      default:
        return Transition.leftToRight;
    }
  }

  static TextTheme _getTextTheme(String font) {
    switch (font) {
      case 'Roboto':
        return GoogleFonts.robotoTextTheme();
      case 'Open Sans':
        return GoogleFonts.openSansTextTheme();
      case 'Lato':
        return GoogleFonts.latoTextTheme();
      case 'Comic Neue':
        return GoogleFonts.comicNeueTextTheme();
      case 'Montserrat':
        return GoogleFonts.montserratTextTheme();
      case 'Nunito':
        return GoogleFonts.nunitoTextTheme();
      case 'Raleway':
        return GoogleFonts.ralewayTextTheme();
      default:
        return GoogleFonts.poppinsTextTheme();
    }
  }

  static String logoGoogle = 'assets/images/google-logo.png';
}

Color primaryColor = const Color(0xff2C96F1);
Color dangerColor = const Color(0xffED6363);
Color successColor = const Color.fromARGB(255, 147, 237, 99);
Color primaryTextColor = const Color(0xff444444);
Color secondaryTextColor = const Color(0xff444444).withOpacity(0.4);
Color bgColor = const Color(0xffffffff);

TextStyle primaryTextStyle = GoogleFonts.lato(color: primaryColor);
TextStyle whiteTextStyle = GoogleFonts.lato(color: bgColor);
TextStyle greyTextStyle = GoogleFonts.lato(color: primaryTextColor);
TextStyle grey2TextStyle = GoogleFonts.lato(color: secondaryTextColor);
