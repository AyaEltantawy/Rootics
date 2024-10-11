import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rootics_final/controller/main_wrapper_controller.dart';
import 'package:rootics_final/custom_widgets/navbar.dart';
import 'package:rootics_final/view/home_page.dart';
import 'package:rootics_final/view/myPlants_page.dart';
import 'package:rootics_final/view/profile_page.dart';
import 'package:rootics_final/view/scan_page.dart';

class MainWrapperPage extends StatelessWidget {
  MainWrapperPage({super.key});
  final MainWrapperController controller = Get.put(MainWrapperController());
  final List<Widget> screens = [
    HomePage(),
    ScanPage(),
    MyPlantsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        extendBody: true,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: screens,
          onPageChanged: (index) {
            controller.currentPage.value = index;
          },
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: controller.currentPage.value,
          onTap: (index) => controller.goToTab(index),
        ),
      );
    });
  }
}
