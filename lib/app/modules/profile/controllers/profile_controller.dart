import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var isDark = false.obs;
  bool get isDarkMode => isDark.value;
  static final userId = "".obs;
  static final userName = "".obs;
  static final userEmail = "".obs;
  static final userImage = "".obs;
  var connectionType = 0.obs;
  late StreamSubscription streamSubscription;
  final Connectivity connectivity = Connectivity();

  setUserDetails(String id, String name, String email, String image) async {
    final prefs = await SharedPreferences.getInstance();
    userId.value = id;
    userName.value = name;
    userEmail.value = email;
    userImage.value = image;
    prefs.setString('id', id);
    prefs.setString('displayName', name);
    prefs.setString('email', email);
    prefs.setString('photoURL', image);
  }

  getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString("id") ?? "";
    final nama = prefs.getString("displayName") ?? "";
    final email = prefs.getString("email") ?? "";
    final image = prefs.getString("photoURL") ?? "";
    userId.value = id;
    userName.value = nama;
    userEmail.value = email;
    userImage.value = image;
  }

  darkMode(value) {
    if (value == true) {
      isDark.value = true;
      Get.changeTheme(ThemeData.dark());
    } else {
      isDark.value = false;
      Get.changeTheme(ThemeData.light());
    }
  }

  Future<void> loadDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    final getDarkMode = prefs.getBool('darkmode') ?? false;
    isDark.value = getDarkMode;
    Get.changeTheme(getDarkMode ? ThemeData.dark() : ThemeData.light());
  }

  String cutString(String inputString) {
    int index = inputString.indexOf(' ');
    if (index != -1) {
      return inputString.substring(0, index).trim();
    } else {
      return inputString;
    }
  }

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return updateState(connectivityResult);
  }

  updateState(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        break;
      default:
        Get.snackbar("Error", "Failed to get connection type");
        break;
    }
  }

  @override
  void onInit() async {
    streamSubscription = connectivity.onConnectivityChanged.listen(updateState);
    await getConnectivityType();
    loadDarkMode();
    getUser();
    super.onInit();
  }

  @override
  void onClose() {
    streamSubscription.cancel();
    super.onClose();
  }
}
