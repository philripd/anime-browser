import 'package:animebrowser/utils/helpers/tuple.dart';
import 'package:meta/meta.dart';

@immutable
class MediaDetailsModel {
  final Trio<String, String?, String> title;
  final String? type;
  final String? format;
  final String status;
  final String description;
  final Trio<int?, int?, int?> startDate;
  final Trio<int?, int?, int?> endDate;
  final String? season;
  final int? seasonYear;
  final int? episodes;
  final int? duration;
  final String source;
  final String coverImage;
  final List<String> genres;
  final List<String> synonyms;
  final int? averageScore;
  final int popularity;
  final int favourites;

  const MediaDetailsModel._({
    required this.title,
    required this.type,
    required this.format,
    required this.status,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.season,
    required this.seasonYear,
    required this.episodes,
    required this.duration,
    required this.source,
    required this.coverImage,
    required this.genres,
    required this.synonyms,
    required this.averageScore,
    required this.popularity,
    required this.favourites,
  });

  factory MediaDetailsModel.fromJson(Map<String, dynamic> json) => MediaDetailsModel._(
    title: Trio(
      json['title']['romaji'] as String,
      json['title']['english'] as String?,
      json['title']['native'] as String,
    ),
    type: json['type'] as String?,
    format: json['format'] as String?,
    status: json['status'] as String,
    description: (json['description'] as String).replaceAll(
      RegExp(r'<[^>]*>'), ''),
    startDate: Trio(
      json['startDate']['year'] as int?,
      json['startDate']['month'] as int?,
      json['startDate']['day'] as int?,
    ),
    endDate: Trio(
      json['endDate']['year'] as int?,
      json['endDate']['month'] as int?,
      json['endDate']['day'] as int?,
    ),
    season: json['season'] as String?,
    seasonYear: json['seasonYear'] as int?,
    episodes: json['episodes'] as int?,
    duration: json['duration'] as int?,
    source: json['season'] as String,
    coverImage: json['coverImage']['extraLarge'] as String,
    genres: (json['genres'] as List<dynamic>).cast<String>(),
    synonyms: (json['synonyms'] as List<dynamic>).cast<String>(),
    averageScore: json['averageScore'] as int?,
    popularity: json['popularity'] as int,
    favourites: json['favourites'] as int,
  );
}
