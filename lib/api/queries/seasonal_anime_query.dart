const String seasonalAnimeQuery = r'''
query(
  $isAdult: Boolean,
  $page: Int,
  $perPage: Int,
  $season: MediaSeason,
  $seasonYear: Int,
  $sort: [MediaSort],
) {
  Page(page: $page, perPage: $perPage) {
    media(
      season: $season,
      seasonYear: $seasonYear,
      type: ANIME,
      isAdult: $isAdult,
      sort: $sort,
    ) {
      id
      title {
        romaji
        english
      }
      description
      coverImage {
        extraLarge
      }
    }
  }
}''';
