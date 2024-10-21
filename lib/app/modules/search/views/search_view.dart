import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/modules/search/controllers/search_controller.dart';


class SearchView extends GetView<SearchControllerG> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search"),),
    );
  }
}
