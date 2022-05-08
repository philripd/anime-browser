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
    }
    description
    coverImage {
      large
    }

    genres

    type
    format

    episodes
    duration
  }
}''';
