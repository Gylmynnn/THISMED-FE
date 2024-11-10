import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:thismed/app/modules/home/views/home_view.dart';
import 'package:thismed/app/modules/post/views/post_view.dart';
import 'package:thismed/app/modules/profile/views/profile_view.dart';
import 'package:thismed/app/modules/search/views/search_view.dart';

class BotnavController extends GetxController {
  final RxInt _selectedIndex = 0.obs;
  final PageController pageC = PageController();

  final RxList<Widget> pages = <Widget>[
    const HomeView(),
    const PostView(),
    const SearchView(),
    const ProfileView()
  ].obs;

  final RxList<Map<String, dynamic>> navs = <Map<String, dynamic>>[
    {
      'icon_on': FluentIcons.home_24_filled,
      'icon_off': FluentIcons.home_24_regular,
      'label': 'Home',
    },
    {
      'icon_on': FluentIcons.add_24_filled,
      'icon_off': FluentIcons.add_24_regular,
      'label': 'Add',
    },
    {
      'icon_on': FluentIcons.search_24_filled,
      'icon_off': FluentIcons.search_24_regular,
      'label': 'Search',
    },
    {
      'icon_on': FluentIcons.people_24_filled,
      'icon_off': FluentIcons.people_24_regular,
      'label': 'Profile',
    },
  ].obs;

  set setSelectedIndex(int value) => _selectedIndex.value = value;
  int get getSelectedIndex => _selectedIndex.value;
}
