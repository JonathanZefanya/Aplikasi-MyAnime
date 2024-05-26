import 'package:MyAnime/app/modules/home/controllers/home_controller.dart';
import 'package:MyAnime/app/modules/searchAnime/controllers/search_anime_controller.dart';
import 'package:get/get.dart';

import '../controllers/bottom_bar_controller.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarController>(
      () => BottomBarController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<SearchAnimeController>(
      () => SearchAnimeController(),
    );
  }
}
