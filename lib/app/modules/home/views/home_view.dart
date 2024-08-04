import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NAVBAR'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Nice',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
