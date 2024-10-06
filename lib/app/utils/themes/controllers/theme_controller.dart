import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/data/events/event_pref.dart';
import 'package:thismed/app/utils/themes/views/theme_view.dart';

class ThemeController extends GetxController {
  final RxBool isDarkMode = false.obs;
  final String _themeKey = 'isDarkMode';

  @override
  void onInit() {
    initThemeValue();
    super.onInit();
  }

  bool initThemeValue() {
    return isDarkMode.value =
        EventPref.readThemeBox(_themeKey, defaultValue: false);
  }

  void switchTheme() {
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    isDarkMode.toggle();
    EventPref.writeThemeBox(_themeKey, isDarkMode.value);
    switchTheme();
  }

  ThemeData getDarkTheme() => ThemeUtilsView.getDarkTheme();
  ThemeData getLightTheme() => ThemeUtilsView.getLightTheme();
}
