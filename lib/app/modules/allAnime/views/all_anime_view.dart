import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/modules/allAnime/controllers/all_anime_controller.dart';
import 'package:flutter_list_anime/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_list_anime/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_list_anime/app/modules/widgets/loading_widget.dart';
import 'package:flutter_list_anime/app/modules/widgets/nointernet_widget.dart';
import 'package:flutter_list_anime/app/routes/app_pages.dart';

import 'package:get/get.dart';

class AllAnime extends GetView<AllAnimeController> {
  const AllAnime({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final darkMode = Get.put(ProfileController());
    final arg = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (arg["top_all"] == "Top All Anime")
              ? arg["top_all"]
              : (arg["airing"] == "Top Airing")
                  ? arg["airing"]
                  : (arg["upcoming"] == "Top Upcoming")
                      ? arg["upcoming"]
                      : (arg["bypopularity"] == "Most Popular")
                          ? arg["bypopularity"]
                          : (arg["favorite"] == "Most Favorited")
                              ? arg["favorite"]
                              : (arg["movie"] == "Top Movie")
                                  ? arg["movie"]
                                  : "",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Obx(
          () => (controller.connectionType.value == 0)
              ? const NoInternet()
              : (controller.isLoading.value)
                  ? LoadingWidget(
                      color:
                          (darkMode.isDark.value) ? Colors.white : Colors.black,
                      text: "Mohon Tunggu....",
                      mediaQuery: MediaQuery.of(context).size.height * 0.9,
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (controller.isFirstPage.value)
                                  ? const Text("")
                                  : InkWell(
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () =>
                                          controller.fetchPreviousPage(),
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: (darkMode.isDark.value)
                                              ? Colors.grey[800]
                                              : Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_back_ios_new,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${controller.currentPage}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "Of",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                (arg["top_all"] == "Top All Anime")
                                    ? "1006"
                                    : (arg["airing"] == "Top Airing")
                                        ? "13"
                                        : (arg["upcoming"] == "Top Upcoming")
                                            ? "18"
                                            : (arg["bypopularity"] ==
                                                    "Most Popular")
                                                ? "1070"
                                                : (arg["favorite"] ==
                                                        "Most Favorited")
                                                    ? "1071"
                                                    : (arg["movie"] ==
                                                            "Top Movie")
                                                        ? "184"
                                                        : "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              (controller.isLastPage.value)
                                  ? Container()
                                  : InkWell(
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onTap: () => controller.fetchNextPage(),
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: (darkMode.isDark.value)
                                              ? Colors.grey[800]
                                              : Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        (arg["top_all"] == "Top All Anime")
                            ? AnimeAll(
                                controller: controller,
                                homeController: homeController)
                            : (arg["airing"] == "Top Airing")
                                ? AnimeAll(
                                    controller: controller,
                                    homeController: homeController)
                                : (arg["upcoming"] == "Top Upcoming")
                                    ? AnimeAll(
                                        controller: controller,
                                        homeController: homeController)
                                    : (arg["bypopularity"] == "Most Popular")
                                        ? AnimeAll(
                                            controller: controller,
                                            homeController: homeController)
                                        : (arg["favorite"] == "Most Favorited")
                                            ? AnimeAll(
                                                controller: controller,
                                                homeController: homeController)
                                            : (arg["movie"] == "Top Movie")
                                                ? AnimeAll(
                                                    controller: controller,
                                                    homeController:
                                                        homeController)
                                                : Container(),
                      ],
                    ),
        ),
      ),
    );
  }
}

class AnimeAll extends StatelessWidget {
  const AnimeAll({
    super.key,
    required this.controller,
    required this.homeController,
  });

  final AllAnimeController controller;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 1.5 / 2.3,
      ),
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        var animeTopCard = controller.allTopAnime[index];
        return InkWell(
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () => Navigator.pushNamed(
            context,
            Routes.DETAIL,
            arguments: {
              "id": animeTopCard.malId,
              "image": animeTopCard.imageUrl,
              "title": animeTopCard.title,
              "aired": animeTopCard.airedFrom,
              "type": animeTopCard.type,
              "rating": animeTopCard.rating,
              "score": animeTopCard.score,
              "member": animeTopCard.members,
              "youtube": animeTopCard.youtubeUrl,
            },
          ),
          child: Card(
            elevation: 5,
            shadowColor: Colors.black,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      animeTopCard.imageUrl,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        animeTopCard.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: controller.allTopAnime.length,
    );
  }
}
