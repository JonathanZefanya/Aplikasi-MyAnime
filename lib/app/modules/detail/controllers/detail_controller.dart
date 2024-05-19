import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/data/base/base_url.dart';
import 'package:flutter_list_anime/app/data/models/anime_model.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailController extends GetxController {
  var isLoading = true.obs;
  var isLoadingFavorite = false.obs;
  var detailAnime = <AnimeModel>[].obs;
  var inputReview = TextEditingController();
  late YoutubePlayerController youtubeController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchDetailAnime(int id) async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/anime/$id"));
      if (response.statusCode == 200) {
        if (Get.arguments["id"] != id) {
          isLoading.value = true;
        } else {
          final Map<String, dynamic> result = jsonDecode(response.body)["data"];
          detailAnime.value = [AnimeModel.fromJson(result)];
          isLoading.value = !isLoading.value;
        }
      }
    } catch (e) {
      debugPrint("Gagal fetch : $e");
    }
  }

  Future<void> addReview(
    int malId,
    String title,
    String profilePicture,
    String username,
    String isiReview,
  ) async {
    CollectionReference reviews = firestore.collection("reviews_$title");
    reviews.add({
      "malId": malId,
      "title": title,
      "username": username,
      "profilePicture": profilePicture,
      "isiReview": isiReview,
      "timestamp": FieldValue.serverTimestamp(),
    });
    inputReview.text = "";
  }

  String formatDate(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(dateTime);
  }

  String formatMonth(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('MMMM yyyy');
    return formatter.format(dateTime);
  }

  String cutString(String inputString) {
    int index = inputString.indexOf('-');
    if (index != -1) {
      return inputString.substring(0, index).trim();
    } else {
      return inputString;
    }
  }

  double convertScoreToRating(double score) {
    // Menggunakan pembulatan ke bawah untuk mendapatkan peringkat 1-5
    double rating = (score / 2).clamp(1.0, 5.0);
    return double.parse(rating.toStringAsFixed(1));
  }

  @override
  void onInit() {
    fetchDetailAnime(Get.arguments["id"]);
    final videoId = YoutubePlayer.convertUrlToId(Get.arguments["youtube"]);
    youtubeController = YoutubePlayerController(
      initialVideoId: videoId.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.onInit();
  }

  @override
  void dispose() {
    youtubeController.dispose();
    super.dispose();
  }
}
