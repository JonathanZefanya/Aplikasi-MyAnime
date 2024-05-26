import 'package:flutter/material.dart';
import 'package:myanime/app/modules/profile/controllers/profile_controller.dart';
import 'package:myanime/app/routes/app_pages.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/nointernet_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final profile = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'myanime',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Obx(
          () => (controller.connectionType.value == 0)
              ? const NoInternet()
              : (controller.isLoading.value)
                  ? LoadingWidget(
                      color:
                          (profile.isDark.value) ? Colors.white : Colors.black,
                      text: "Mohon Tunggu....",
                      mediaQuery: MediaQuery.of(context).size.height * 0.9,
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ExpandableCarousel.builder(
                            options: CarouselOptions(
                              floatingIndicator: true,
                              autoPlay: true,
                              showIndicator: true,
                              slideIndicator: CircularSlideIndicator(
                                indicatorRadius: 5,
                                indicatorBackgroundColor: (profile.isDark.value)
                                    ? Colors.black
                                    : Colors.white,
                                currentIndicatorColor: Colors.blue,
                              ),
                            ),
                            itemCount: controller.animeImageCard.length,
                            itemBuilder: (context, index, pageViewIndex) {
                              var animeImageCard =
                                  controller.animeImageCard[index];
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    animeImageCard.imageUrlBig,
                                    width: MediaQuery.of(context).size.width,
                                    height: 220,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 5,
                        ),
                        const TitleText(
                          title: "Top All Anime",
                          argumentKey: "top_all",
                          argumentField: "Top All Anime",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              var animeTopCard = controller.animeTopCard[index];
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
                                  child: SizedBox(
                                    width: 160,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              animeTopCard.imageUrl,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              animeTopCard.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.animeTopCard.length,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const TitleText(
                          title: "Top Airing",
                          argumentKey: "airing",
                          argumentField: "Top Airing",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              var animeRecomCard =
                                  controller.animeAiringCard[index];
                              return InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.DETAIL,
                                  arguments: {
                                    "id": animeRecomCard.malId,
                                    "image": animeRecomCard.imageUrl,
                                    "title": animeRecomCard.title,
                                    "aired": animeRecomCard.airedFrom,
                                    "type": animeRecomCard.type,
                                    "rating": animeRecomCard.rating,
                                    "score": animeRecomCard.score,
                                    "member": animeRecomCard.members,
                                    "youtube": animeRecomCard.youtubeUrl,
                                  },
                                ),
                                child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: SizedBox(
                                    width: 160,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              animeRecomCard.imageUrl,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                    child: Text(
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      animeRecomCard.title,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.animeAiringCard.length,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const TitleText(
                          title: "Top Upcoming",
                          argumentKey: "upcoming",
                          argumentField: "Top Upcoming",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              var animeUpcomingCard =
                                  controller.animeUpcomingCard[index];
                              return InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.DETAIL,
                                  arguments: {
                                    "id": animeUpcomingCard.malId,
                                    "image": animeUpcomingCard.imageUrl,
                                    "title": animeUpcomingCard.title,
                                    "aired": animeUpcomingCard.airedFrom,
                                    "type": animeUpcomingCard.type,
                                    "rating": animeUpcomingCard.rating,
                                    "score": animeUpcomingCard.score,
                                    "member": animeUpcomingCard.members,
                                    "youtube": animeUpcomingCard.youtubeUrl,
                                  },
                                ),
                                child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: SizedBox(
                                    width: 160,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              animeUpcomingCard.imageUrl,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              animeUpcomingCard.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.animeUpcomingCard.length,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const TitleText(
                          title: "Top Movie",
                          argumentKey: "movie",
                          argumentField: "Top Movie",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              var animeMovieCard =
                                  controller.animeMovieCard[index];
                              return InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.DETAIL,
                                  arguments: {
                                    "id": animeMovieCard.malId,
                                    "image": animeMovieCard.imageUrl,
                                    "title": animeMovieCard.title,
                                    "aired": animeMovieCard.airedFrom,
                                    "type": animeMovieCard.type,
                                    "rating": animeMovieCard.rating,
                                    "score": animeMovieCard.score,
                                    "member": animeMovieCard.members,
                                    "youtube": animeMovieCard.youtubeUrl,
                                  },
                                ),
                                child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: SizedBox(
                                    width: 160,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              animeMovieCard.imageUrl,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              animeMovieCard.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.animeMovieCard.length,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const TitleText(
                          title: "Most Popular",
                          argumentKey: "bypopularity",
                          argumentField: "Most Popular",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              var animePopularCard =
                                  controller.animePopularCard[index];
                              return InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.DETAIL,
                                  arguments: {
                                    "id": animePopularCard.malId,
                                    "image": animePopularCard.imageUrl,
                                    "title": animePopularCard.title,
                                    "aired": animePopularCard.airedFrom,
                                    "type": animePopularCard.type,
                                    "rating": animePopularCard.rating,
                                    "score": animePopularCard.score,
                                    "member": animePopularCard.members,
                                    "youtube": animePopularCard.youtubeUrl,
                                  },
                                ),
                                child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: SizedBox(
                                    width: 160,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              animePopularCard.imageUrl,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              animePopularCard.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.animePopularCard.length,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const TitleText(
                          title: "Most Favorited",
                          argumentKey: "favorite",
                          argumentField: "Most Favorited",
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 280,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              var animeFavoriteCard =
                                  controller.animeFavoriteCard[index];
                              return InkWell(
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routes.DETAIL,
                                  arguments: {
                                    "id": animeFavoriteCard.malId,
                                    "image": animeFavoriteCard.imageUrl,
                                    "title": animeFavoriteCard.title,
                                    "aired": animeFavoriteCard.airedFrom,
                                    "type": animeFavoriteCard.type,
                                    "rating": animeFavoriteCard.rating,
                                    "score": animeFavoriteCard.score,
                                    "member": animeFavoriteCard.members,
                                    "youtube": animeFavoriteCard.youtubeUrl,
                                  },
                                ),
                                child: Card(
                                  elevation: 5,
                                  shadowColor: Colors.black,
                                  child: SizedBox(
                                    width: 160,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              animeFavoriteCard.imageUrl,
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              animeFavoriteCard.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.animeFavoriteCard.length,
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String title;
  final String argumentKey;
  final String argumentField;
  const TitleText({
    super.key,
    required this.title,
    required this.argumentKey,
    required this.argumentField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => Navigator.pushNamed(
              context,
              Routes.ALL_TOP_ANIME,
              arguments: {
                argumentKey: argumentField,
              },
            ),
            child: const Text(
              "Lihat Lainnya",
              style: TextStyle(
                fontSize: 15,
                decoration: TextDecoration.underline,
                color: Colors.blue,
                decorationColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
