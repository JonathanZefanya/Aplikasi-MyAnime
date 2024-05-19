import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_list_anime/app/data/base/base_url.dart';
import 'package:flutter_list_anime/app/data/models/anime_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchAnimeController extends GetxController {
  final cariAnime = TextEditingController();
  final cardSearchAnime = <AnimeModel>[].obs;
  var isLoading = true.obs;
  var isHide = true.obs;
  var connectionType = 0.obs;
  late StreamSubscription streamSubscription;
  final Connectivity connectivity = Connectivity();

  Future<void> fetchSearchAnime(String keyword) async {
    try {
      var response =
          await http.get(Uri.parse("$baseUrl/anime?q=$keyword&sfw=true"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        cardSearchAnime.value =
            result.map((e) => AnimeModel.fromJson(e)).toList();
        isLoading.value = false;
        isHide.value = false;
        if (keyword == "" || cariAnime.text == "") {
          resetInput();
        }
      }
    } catch (e) {
      debugPrint("Error : $e");
    }
  }

  void resetInput() {
    cariAnime.clear();
    cardSearchAnime.clear();
    isLoading.value = true;
    isHide.value = true;
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
