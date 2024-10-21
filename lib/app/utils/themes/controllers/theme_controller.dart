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

  bool get getDarkMode => isDarkMode.value;
  set setDarkMode(dynamic value) => isDarkMode.value = value;

  bool initThemeValue() {
    return setDarkMode = EventPref.readThemeBox(_themeKey, defaultValue: false);
  }

  void switchTheme() {
    Get.changeThemeMode(getDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    isDarkMode.toggle();
    EventPref.writeThemeBox(_themeKey, getDarkMode);
    switchTheme();
  }

  ThemeMode getTheme() => getDarkMode ? ThemeMode.dark : ThemeMode.light;
  ThemeData getDarkTheme() => ThemeUtilsView.getDarkTheme();
  ThemeData getLightTheme() => ThemeUtilsView.getLightTheme();
}
