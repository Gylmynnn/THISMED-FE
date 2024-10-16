import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thismed/app/modules/splash/controllers/splash_controller.dart';
import 'package:thismed/app/utils/hellper/asset.dart';
import 'package:thismed/app/utils/hellper/layout.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(controller),
      backgroundColor: Themes.primaryTheme,
    );
  }
}

FutureBuilder _buildBody(SplashController controller) {
  return FutureBuilder(
    future: controller.loadings(),
    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      return _goto(snapshot);
    },
  );
}

Widget _goto(AsyncSnapshot<void> snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(
        child: Image.asset(
      Assets.mainLogo,
      width: MediaQuerys.widthMQ / 2,
      height: MediaQuerys.heightMQ / 2,
    ));
  } else {
    return const SizedBox();
  }
}
