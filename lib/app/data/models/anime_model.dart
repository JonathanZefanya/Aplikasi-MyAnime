class AnimeModel {
  late int malId;
  late String url;
  late String imageUrl;
  late String imageUrlBig;
  late String title;
  late String youtubeId;
  late String youtubeUrl;
  late String titleEnglish;
  late String titleJapanese;
  late String type;
  late int episodes;
  late String status;
  late String airedFrom;
  late String airedTo;
  late String duration;
  late String rating;
  late double score;
  late int rank;
  late int popularity;
  late int members;
  late int favorites;
  late String synopsis;
  late String background;
  late String season;
  late int year;
  late List<Map<String, dynamic>> producers;
  late List<Map<String, dynamic>> studios;
  late List<Map<String, dynamic>> genres;
  late List<Map<String, dynamic>> demographics;

  AnimeModel({
    required this.malId,
    required this.url,
    required this.imageUrl,
    required this.imageUrlBig,
    required this.title,
    required this.youtubeId,
    required this.youtubeUrl,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.type,
    required this.episodes,
    required this.status,
    required this.airedFrom,
    required this.airedTo,
    required this.duration,
    required this.rating,
    required this.score,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.synopsis,
    required this.season,
    required this.year,
    required this.producers,
    required this.studios,
    required this.genres,
    required this.demographics,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      malId: json["mal_id"] ?? 0,
      url: json["url"] ?? "",
      imageUrl: json["images"]["jpg"]["image_url"] ?? "",
      imageUrlBig: json["images"]["jpg"]["large_image_url"] ?? "",
      title: json["title"] ?? "",
      youtubeId: json["trailer"]["youtube_id"] ?? "",
      youtubeUrl: json["trailer"]["url"] ?? "",
      titleEnglish: json["title_english"] ?? "",
      titleJapanese: json["title_japanese"] ?? "",
      type: json["type"] ?? "",
      episodes: json["episodes"] ?? 0,
      status: json["status"] ?? "",
      airedFrom: json["aired"]["from"] ?? "",
      airedTo: json["aired"]["to"] ?? "",
      duration: json["duration"] ?? "",
      rating: json["rating"] ?? "",
      score: (json["score"] ?? 0).toDouble(),
      rank: json["rank"] ?? 0,
      popularity: json["popularity"] ?? 0,
      members: json["members"] ?? 0,
      favorites: json["favorites"] ?? 0,
      synopsis: json["synopsis"] ?? "",
      season: json["season"] ?? "",
      year: json["year"] ?? 0,
      producers: List<Map<String, dynamic>>.from(json["producers"] ?? []),
      studios: List<Map<String, dynamic>>.from(json["studios"] ?? []),
      genres: List<Map<String, dynamic>>.from(json["genres"] ?? []),
      demographics: List<Map<String, dynamic>>.from(json["demographics"] ?? []),
    );
  }
}
