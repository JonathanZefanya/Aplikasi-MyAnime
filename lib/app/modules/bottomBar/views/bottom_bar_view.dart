import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/modules/home/views/home_view.dart';
import 'package:flutter_list_anime/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_list_anime/app/modules/profile/views/profile_view.dart';
import 'package:flutter_list_anime/app/modules/searchAnime/views/search_anime_view.dart';

import 'package:get/get.dart';

import '../controllers/bottom_bar_controller.dart';

class BottomBarView extends GetView<BottomBarController> {
  const BottomBarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final modeControll = Get.put(ProfileController());
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            HomeView(),
            SearchAnimeView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile",
              ),
            ],
            currentIndex: controller.currentIndex.value,
            elevation: 0,
            backgroundColor:
                (modeControll.isDark.value) ? Colors.black : Colors.white,
            unselectedItemColor: Colors.grey,
            selectedItemColor:
                (modeControll.isDark.value) ? Colors.white : Colors.black,
            unselectedIconTheme: const IconThemeData(size: 25),
            selectedIconTheme: const IconThemeData(size: 30),
            onTap: (value) => controller.changeIndex(value),
          ),
        ),
      ),
    );
  }
}
