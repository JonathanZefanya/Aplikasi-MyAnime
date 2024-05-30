import 'package:get/get.dart';

import '../controllers/developer_controller.dart';

class DeveloperBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeveloperController>(
      () => DeveloperController(),
    );
  }
}