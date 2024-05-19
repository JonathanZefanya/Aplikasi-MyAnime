import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_list_anime/app/data/base/base_url.dart';
import 'package:flutter_list_anime/app/data/models/anime_model.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var animeTopCard = <AnimeModel>[].obs;
  var animeAiringCard = <AnimeModel>[].obs;
  var animeUpcomingCard = <AnimeModel>[].obs;
  var animePopularCard = <AnimeModel>[].obs;
  var animeMovieCard = <AnimeModel>[].obs;
  var animeFavoriteCard = <AnimeModel>[].obs;
  var animeImageCard = <AnimeModel>[].obs;
  var connectionType = 0.obs;
  late StreamSubscription streamSubscription;
  final Connectivity connectivity = Connectivity();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchAnime(String filter) async {
    if (filter == "airing") {
      try {
        var response = await http.get(
            Uri.parse("$baseUrl/top/anime?&limit=25&filter=$filter&sfw=true"));
        if (response.statusCode == 200) {
          final List result = jsonDecode(response.body)["data"];
          animeAiringCard.value =
              result.map((e) => AnimeModel.fromJson(e)).toList();
        }
      } catch (e) {
        debugPrint("Gagal fetch $e");
      }
    } else if (filter == "upcoming") {
      try {
        var response = await http.get(
            Uri.parse("$baseUrl/top/anime?limit=25&filter=$filter&sfw=true"));
        if (response.statusCode == 200) {
          final List result = jsonDecode(response.body)["data"];
          animeUpcomingCard.value =
              result.map((e) => AnimeModel.fromJson(e)).toList();
        }
      } catch (e) {
        debugPrint("Gagal fetch$e");
      }
    } else if (filter == "bypopularity") {
      try {
        var response = await http.get(
            Uri.parse("$baseUrl/top/anime?limit=25&filter=$filter&sfw=true"));
        if (response.statusCode == 200) {
          final List result = jsonDecode(response.body)["data"];
          animePopularCard.value =
              result.map((e) => AnimeModel.fromJson(e)).toList();
        }
      } catch (e) {
        debugPrint("Gagal fetch$e");
      }
    } else if (filter == "favorite") {
      try {
        var response = await http.get(
            Uri.parse("$baseUrl/top/anime?limit=25&filter=$filter&sfw=true"));
        if (response.statusCode == 200) {
          final List result = jsonDecode(response.body)["data"];
          animeFavoriteCard.value =
              result.map((e) => AnimeModel.fromJson(e)).toList();
        }
      } catch (e) {
        debugPrint("Gagal fetch$e");
      }
    } else if (filter == "") {
      try {
        var response =
            await http.get(Uri.parse("$baseUrl/top/anime?limit=25&sfw=true"));
        if (response.statusCode == 200) {
          final List result = jsonDecode(response.body)["data"];
          animeTopCard.value =
              result.map((e) => AnimeModel.fromJson(e)).toList();
          isLoading.value = false;
        }
      } catch (e) {
        debugPrint("Gagal fetch $e");
      }
    }
  }

  Future<void> fetchAnimeMovie() async {
    try {
      var response =
          await http.get(Uri.parse("$baseUrl/top/anime?type=movie&limit=25"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        animeMovieCard.value =
            result.map((e) => AnimeModel.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint("Gagal fetch $e");
    }
  }

  Future<void> fetchImage() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/top/anime?limit=5"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        animeImageCard.value =
            result.map((e) => AnimeModel.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint("Gagal fetch $e");
    }
  }

  Future<void> addFavorites(
    String id,
    String username,
    int malId,
    String title,
    String imageUrl,
    String airedFrom,
    String type,
    String rating,
    double score,
    int members,
    String youtubeUrl,
  ) async {
    CollectionReference favorites = firestore.collection("favorites_$username");
    favorites.add({
      "id": id,
      "username": username,
      "malId": malId,
      "title": title,
      "imageUrl": imageUrl,
      "airedFrom": airedFrom,
      "type": type,
      "rating": rating,
      "score": score,
      "members": members,
      "youtubeUrl": youtubeUrl,
      "createdAt": FieldValue.serverTimestamp(),
    });
    // getFavorites(username);
  }

  Future<void> deleteFavorites(String id, String username, int malId) async {
    QuerySnapshot favoritesSnapshot = await firestore
        .collection("favorites_$username")
        .where("id", isEqualTo: id)
        .where("malId", isEqualTo: malId)
        .get();

    // Loop through the documents to delete each matching document
    for (QueryDocumentSnapshot doc in favoritesSnapshot.docs) {
      doc.reference.delete();
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
        if (animeTopCard.isEmpty) {
          await fetchImage();
          await fetchAnimeMovie();
          await fetchAnime("");
          await fetchAnime("airing");
          await fetchAnime("upcoming");
          await fetchAnime("bypopularity");
          await fetchAnime("favorite");
        }
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        if (animeTopCard.isEmpty) {
          await fetchImage();
          await fetchAnimeMovie();
          await fetchAnime("");
          await fetchAnime("airing");
          await fetchAnime("upcoming");
          await fetchAnime("bypopularity");
          await fetchAnime("favorite");
        }
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
    if (connectionType.value != 0) {
      await fetchImage();
      await fetchAnimeMovie();
      await fetchAnime("");
      await fetchAnime("airing");
      await fetchAnime("upcoming");
      await fetchAnime("bypopularity");
      await fetchAnime("favorite");
      // await getFavorites(ProfileController.userName.value);
    }
    super.onInit();
  }

  @override
  void onClose() {
    streamSubscription.cancel();
    super.onClose();
  }
}
