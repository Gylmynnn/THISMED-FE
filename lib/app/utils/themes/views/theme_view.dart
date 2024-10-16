import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeUtilsView {
  static ThemeData getLightTheme() {
    return ThemeData(
      colorScheme: const ColorScheme.light(primary: Colorsss.primary),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      brightness: Brightness.light,
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        )),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(primary: Colorsss.primary),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
      ),
      brightness: Brightness.dark,
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
    );
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

class Colorsss {
  static const Color primary = Color(0xff2C96F1);
}

Color primaryColor = const Color(0xff2C96F1);
Color dangerColor = const Color(0xffED6363);
Color successColor = const Color.fromARGB(255, 147, 237, 99);
Color primaryTextColor = const Color(0xff444444);
Color secondaryTextColor = const Color(0xff666666).withOpacity(0.2);
Color bgColor = const Color(0xffffffff);

TextStyle primaryTextStyle = GoogleFonts.lato(color: primaryColor);
TextStyle whiteTextStyle = GoogleFonts.lato(color: bgColor);
TextStyle greyTextStyle = GoogleFonts.lato(color: primaryTextColor);
TextStyle grey2TextStyle = GoogleFonts.lato(color: secondaryTextColor);
