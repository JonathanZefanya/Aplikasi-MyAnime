import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FavoriteController extends GetxController {
  var isLoading = false.obs;
  var connectionType = 0.obs;
  late StreamSubscription streamSubscription;
  final Connectivity connectivity = Connectivity();

  String formatMonth(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('MMMM yyyy');
    return formatter.format(dateTime);
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
    super.onInit();
  }

  @override
  void onClose() {
    streamSubscription.cancel();
    super.onClose();
  }
}
