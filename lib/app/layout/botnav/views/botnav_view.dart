import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:thismed/app/layout/botnav/controllers/botnav_controller.dart';

class BotnavView extends GetView<BotnavController> {
  const BotnavView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageC,
        children: controller.pages,
        onPageChanged: (int index) {
          controller.setSelectedIndex = index;
        },
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: RxList.generate(controller.navs.length, (int index) {
            final Map<String, dynamic> nav = controller.navs[index];
            return BottomNavigationBarItem(
              icon: Icon(nav['icon_off']),
              label: '',
              activeIcon: Icon(nav['icon_on']),
            );
          }),
          currentIndex: controller.getSelectedIndex,
          onTap: (int index) {
            controller.pageC.animateToPage(index,
                duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
          },
        ),
      ),
    );
  }
}
