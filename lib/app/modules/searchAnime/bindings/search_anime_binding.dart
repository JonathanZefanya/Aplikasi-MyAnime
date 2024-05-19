import 'package:get/get.dart';

import '../controllers/search_anime_controller.dart';

class SearchAnimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchAnimeController>(
      () => SearchAnimeController(),
    );
  }
}
