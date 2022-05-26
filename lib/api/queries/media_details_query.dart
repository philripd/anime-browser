const String mediaDetailsQuery = r'''
query(
  $id: Int
) {
  Media(
    id: $id
  ) {
    title {
      romaji
      english
      native
    }
    type
    format
    status(version: 2)
    description
    startDate {
      year
      month
      day
    }
    endDate {
      year
      month
      day
    }
    season
    seasonYear
    episodes
    duration
    source
    coverImage {
      extraLarge
    }
    genres
    synonyms
    averageScore
    popularity
    favourites
    nextAiringEpisode {
      airingAt
      episode
    }
  }
}''';
