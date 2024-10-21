import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/modules/home/views/home_view.dart';
import 'package:thismed/app/modules/search/views/search_view.dart';

class BotnavController extends GetxController {
  final RxInt _selectedIndex = 0.obs;
  final PageController pageC = PageController();

  final RxList<Widget> pages = <Widget>[
    const HomeView(),
    const SearchView(),
  ].obs;

  final RxList<Map<String, dynamic>> navs = <Map<String, dynamic>>[
    {
      'icon_on': CupertinoIcons.house_fill,
      'icon_off': CupertinoIcons.house,
      'label': 'Home',
    },
    {
      'icon_on': CupertinoIcons.search_circle_fill,
      'icon_off': CupertinoIcons.search_circle,
      'label': 'Search',
    },
  ].obs;

  set setSelectedIndex(int value) => _selectedIndex.value = value;
  int get getSelectedIndex => _selectedIndex.value;
}
