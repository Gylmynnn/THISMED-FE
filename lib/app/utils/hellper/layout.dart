import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class Gaps {
  static const Widget small = Gap(10);
  static const Widget medium = Gap(20);
  static const Widget large = Gap(30);

  static Widget custom(double value) {
    return Gap(value);
  }
}

class Themes {
  static final primaryTheme = Get.theme.colorScheme.primary;
}

class MediaQuerys {
  static double widthMQ = Get.width;
  static double heightMQ = Get.height;
}

class Paddings {
  static Widget smallAll(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }

  static Widget mediumAll(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }

  static Widget largeAll(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: child,
    );
  }

  static Widget smallSy(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: child,
    );
  }

  static Widget mediumSy(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: child,
    );
  }

  static Widget largeSy(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: child,
    );
  }

  static Widget smallSx(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: child,
    );
  }

  static Widget mediumSx(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: child,
    );
  }

  static Widget largeSx(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: child,
    );
  }

  static Widget customAll(Widget child,
      {double? T, double? B, double? L, double? R}) {
    return Padding(
      padding: EdgeInsets.only(
          top: T ?? 0, bottom: B ?? 0, left: L ?? 0, right: R ?? 0),
      child: child,
    );
  }

  static Widget customSyx(Widget child, {double? sY, double? sX}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sY ?? 0, horizontal: sX ?? 0),
      child: child,
    );
  }
}
