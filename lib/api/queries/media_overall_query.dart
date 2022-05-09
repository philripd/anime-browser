const String mediaOverallQuery = r'''
query(
  $page: Int,
  $perPage: Int,
) {
  Page(page: $page, perPage: $perPage) {
    media(
      sort: POPULARITY_DESC
    ) {
      id
      title {
        romaji
        english
       }
      description
      coverImage {
        large
      }
    }
  }
}''';