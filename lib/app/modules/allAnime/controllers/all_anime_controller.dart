import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_list_anime/app/data/base/base_url.dart';
import 'package:flutter_list_anime/app/data/models/anime_model.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;

class AllAnimeController extends GetxController {
  var isLoading = true.obs;
  var allTopAnime = <AnimeModel>[].obs;
  var currentPage = 1.obs;
  var isFirstPage = true.obs;
  var isLastPage = false.obs;
  var connectionType = 0.obs;
  late StreamSubscription streamSubscription;
  final Connectivity connectivity = Connectivity();

  Future<void> fetchAllAnime(String filter, int page) async {
    if (filter == "") {
      try {
        var response =
            await http.get(Uri.parse("$baseUrl/top/anime?page=$page&sfw=true"));
        if (response.statusCode == 200) {
          if (page == 1) {
            isFirstPage.value = true;
          } else {
            isFirstPage.value = false;
          }
          final List result = jsonDecode(response.body)["data"];
          allTopAnime.value =
              result.map((e) => AnimeModel.fromJson(e)).toList();
          isLoading.value = false;
          currentPage.value = page;
        }
      } catch (e) {
        debugPrint("Gagal fetch $e");
      }
    } else if (filter == "airing") {
      try {
        var response = await http.get(
            Uri.parse("$baseUrl/top/anime?filter=$filter&page=$page&sfw=true"));
        if (response.statusCode == 200) {
          if (page == 1) {
            isFirstPage.value = true;
          } else {
            isFirstPage.value = false;
          }
          final List result = jsonDecode(response.body)["data"];
          allTopAnime.value =
              result.map((e) => AnimeModel.fromJson(e)).toList();
          isLoading.value = false;
          currentPage.value = page;
        }
      } catch (e) {
        debugPrint("Gagal fetch $e");
      }
    } else if (filter == "upcoming") {
      try {
        var response = await http.get(
            Uri.parse("$baseUrl/top/anime?filter=$filter&page=$page&sfw=true"));
        if (response.statusCode == 200) {
          if (page == 1) {
            isFirstPage.value = true;
          } else {
            isFirstPage.value = false;
          }
          final List result = jsonDecode(response.body)["data"];
          allTopAnime.value =
              result.map((e) => AnimeModel.fromJson(e)).toList();
          isLoading.value = false;
          currentPage.value = page;
        }
      } catch (e) {
        debugPrint("Gagal fetch $e");
      }
    } else if (filter == "bypopularity") {
      try {
        var response = await http.get(
            Uri.parse("$baseUrl/top/anime?filter=$filter&page=$page&sfw=true"));
        if (response.statusCode == 200) {
          if (page == 1) {
            isFirstPage.value = true;
          } else {
            isFirstPage.value = false;
          }
          final List result = jsonDecode(response.body)["data"];
          allTopAnime.value =
              result.map((e) => AnimeModel.fromJson(e)).toList();
          isLoading.value = false;
          currentPage.value = page;
        }
      } catch (e) {
        debugPrint("Gagal fetch $e");
      }
    } else if (filter == "favorite") {
      try {
        var response = await http.get(
            Uri.parse("$baseUrl/top/anime?filter=$filter&page=$page&sfw=true"));
        if (response.statusCode == 200) {
          if (page == 1) {
            isFirstPage.value = true;
          } else {
            isFirstPage.value = false;
          }
          final List result = jsonDecode(response.body)["data"];
          allTopAnime.value =
              result.map((e) => AnimeModel.fromJson(e)).toList();
          isLoading.value = false;
          currentPage.value = page;
        }
      } catch (e) {
        debugPrint("Gagal fetch $e");
      }
    }
  }

  Future<void> fetchAnimeMovie(int page) async {
    try {
      var response = await http
          .get(Uri.parse("$baseUrl/top/anime?page=$page&type=movie&sfw=true"));
      if (response.statusCode == 200) {
        if (page == 1) {
          isFirstPage.value = true;
        } else {
          isFirstPage.value = false;
        }
        final List result = jsonDecode(response.body)["data"];
        allTopAnime.value = result.map((e) => AnimeModel.fromJson(e)).toList();
        isLoading.value = false;
        currentPage.value = page;
      }
    } catch (e) {
      debugPrint("Gagal fetch $e");
    }
  }

  // Fungsi untuk mengambil halaman berikutnya
  Future<void> fetchNextPage() async {
    if (Get.arguments["top_all"] == "Top All Anime") {
      isLoading.value = true;
      await fetchAllAnime("", currentPage.value + 1);
    } else if (Get.arguments["airing"] == "Top Airing") {
      isLoading.value = true;
      await fetchAllAnime("airing", currentPage.value + 1);
      if (currentPage.value == 13) {
        isLastPage.value = true;
      }
    } else if (Get.arguments["upcoming"] == "Top Upcoming") {
      isLoading.value = true;
      await fetchAllAnime("upcoming", currentPage.value + 1);
      if (currentPage.value == 18) {
        isLastPage.value = true;
      }
    } else if (Get.arguments["bypopularity"] == "Most Popular") {
      isLoading.value = true;
      await fetchAllAnime("bypopularity", currentPage.value + 1);
      if (currentPage.value == 1070) {
        isLastPage.value = true;
      }
    } else if (Get.arguments["favorite"] == "Most Favorited") {
      isLoading.value = true;
      await fetchAllAnime("favorite", currentPage.value + 1);
      if (currentPage.value == 1071) {
        isLastPage.value = true;
      }
    } else if (Get.arguments["movie"] == "Top Movie") {
      isLoading.value = true;
      await fetchAnimeMovie(currentPage.value + 1);
      if (currentPage.value == 184) {
        isLastPage.value = true;
      }
    }
  }

  // Fungsi untuk mengambil halaman sebelumnya
  Future<void> fetchPreviousPage() async {
    if (Get.arguments["top_all"] == "Top All Anime") {
      isLoading.value = true;
      if (currentPage.value > 1) {
        await fetchAllAnime("", currentPage.value - 1);
      }
    } else if (Get.arguments["airing"] == "Top Airing") {
      isLoading.value = true;
      if (currentPage.value > 1) {
        await fetchAllAnime("airing", currentPage.value - 1);
      }
    } else if (Get.arguments["upcoming"] == "Top Upcoming") {
      isLoading.value = true;
      if (currentPage.value > 1) {
        await fetchAllAnime("upcoming", currentPage.value - 1);
      }
    } else if (Get.arguments["bypopularity"] == "Most Popular") {
      isLoading.value = true;
      if (currentPage.value > 1) {
        await fetchAllAnime("bypopularity", currentPage.value - 1);
      }
    } else if (Get.arguments["favorite"] == "Most Favorited") {
      isLoading.value = true;
      if (currentPage.value > 1) {
        await fetchAllAnime("favorite", currentPage.value - 1);
      }
    } else if (Get.arguments["movie"] == "Top Movie") {
      isLoading.value = true;
      if (currentPage.value > 1) {
        await fetchAnimeMovie(currentPage.value - 1);
      }
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
        if (Get.arguments["top_all"] == "Top All Anime") {
          if (allTopAnime.isEmpty) {
            await fetchAllAnime("", 1);
          }
          break;
        } else if (Get.arguments["airing"] == "Top Airing") {
          if (allTopAnime.isEmpty) {
            await fetchAllAnime("airing", 1);
          }
          break;
        } else if (Get.arguments["upcoming"] == "Top Upcoming") {
          if (allTopAnime.isEmpty) {
            await fetchAllAnime("upcoming", 1);
          }
          break;
        } else if (Get.arguments["bypopularity"] == "Most Popular") {
          if (allTopAnime.isEmpty) {
            await fetchAllAnime("bypopularity", 1);
          }
          break;
        } else if (Get.arguments["favorite"] == "Most Favorited") {
          if (allTopAnime.isEmpty) {
            await fetchAllAnime("favorite", 1);
          }
          break;
        } else if (Get.arguments["movie"] == "Top Movie") {
          if (allTopAnime.isEmpty) {
            await fetchAnimeMovie(1);
          }
          break;
        }
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        if (Get.arguments["top_all"] == "Top All Anime") {
          if (allTopAnime.isEmpty) {
            await fetchAllAnime("", 1);
          }
          break;
        } else if (Get.arguments["airing"] == "Top Airing") {
          if (allTopAnime.isEmpty) {
            await fetchAllAnime("airing", 1);
          }
          break;
        } else if (Get.arguments["upcoming"] == "Top Upcoming") {
          if (allTopAnime.isEmpty) {
            await fetchAllAnime("upcoming", 1);
          }
          break;
        } else if (Get.arguments["bypopularity"] == "Most Popular") {
          if (allTopAnime.isEmpty) {
            await fetchAllAnime("bypopularity", 1);
          }
          break;
        } else if (Get.arguments["favorite"] == "Most Favorited") {
          if (allTopAnime.isEmpty) {
            await fetchAllAnime("favorite", 1);
          }
          break;
        } else if (Get.arguments["movie"] == "Top Movie") {
          if (allTopAnime.isEmpty) {
            await fetchAnimeMovie(1);
          }
          break;
        }
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
    if (Get.arguments["top_all"] == "Top All Anime") {
      if (connectionType.value != 0) {
        await fetchAllAnime("", 1);
      }
    } else if (Get.arguments["airing"] == "Top Airing") {
      if (connectionType.value != 0) {
        await fetchAllAnime("airing", 1);
      }
    } else if (Get.arguments["upcoming"] == "Top Upcoming") {
      if (connectionType.value != 0) {
        await fetchAllAnime("upcoming", 1);
      }
    } else if (Get.arguments["bypopularity"] == "Most Popular") {
      if (connectionType.value != 0) {
        await fetchAllAnime("bypopularity", 1);
      }
    } else if (Get.arguments["favorite"] == "Most favorited") {
      if (connectionType.value != 0) {
        await fetchAllAnime("favorite", 1);
      }
    } else if (Get.arguments["movie"] == "Top Movie") {
      if (connectionType.value != 0) {
        await fetchAnimeMovie(1);
      }
    }
    super.onInit();
  }

  @override
  void onClose() {
    streamSubscription.cancel();
    super.onClose();
  }
}
