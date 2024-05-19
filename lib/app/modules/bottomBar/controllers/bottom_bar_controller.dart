import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var currentIndex = 0.obs;
  void changeIndex(int value) {
    currentIndex.value = value;
  }
}
