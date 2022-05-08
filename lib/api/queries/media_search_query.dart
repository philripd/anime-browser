const String mediaSearchQuery = r'''
query(
  $page: Int,
  $perPage: Int,
  $search: String,
  $sort: [MediaSort],
) {
  Page(page: $page, perPage: $perPage) {
    media(
      search: $search,
      sort: $sort,
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
