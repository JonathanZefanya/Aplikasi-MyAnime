import 'package:get/get.dart';

import '../controllers/all_anime_controller.dart';

class AllAnimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllAnimeController>(
      () => AllAnimeController(),
    );
  }
}
