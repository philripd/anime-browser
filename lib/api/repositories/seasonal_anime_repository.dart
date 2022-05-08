import 'dart:convert';

import 'package:animebrowser/api/api_provider.dart';
import 'package:animebrowser/api/models/graphql_request_model.dart';
import 'package:animebrowser/api/models/media_list_model.dart';
import 'package:animebrowser/api/queries/seasonal_anime_query.dart';
import 'package:animebrowser/config/dependencies_config.dart';
import 'package:animebrowser/utils/helpers/format_query.dart';
import 'package:animebrowser/utils/helpers/time.dart';
import 'package:animebrowser/utils/helpers/tuple.dart';
import 'package:flutter/foundation.dart';

typedef FetchSeasonalAnimeInputType = Pair<APIProvider, GraphQLRequestModel>;

abstract class ISeasonalAnimeRepository {
  Future<List<SummaryModel>> fetchSeasonalAnime(int page, int perPage);
}

class SeasonalAnimeRepository implements ISeasonalAnimeRepository {
  final APIProvider _apiProvider;

  SeasonalAnimeRepository() : _apiProvider = getIt.get<APIProvider>();

  @override
  Future<List<SummaryModel>> fetchSeasonalAnime(int page, int perPage) async =>
    compute<FetchSeasonalAnimeInputType, List<SummaryModel>>(
      _parseSeasonalAnime,
      Pair(
        _apiProvider,
        GraphQLRequestModel(
          query: formatQuery(seasonalAnimeQuery),
          variables: {
            'isAdult': false,
            'page': page,
            'perPage': perPage,
            'season': getCurrentSeason(),
            'seasonYear': getCurrentYear(),
            'sort': ["POPULARITY_DESC"],
          },
        ),
      ),
    );
}

Future<List<SummaryModel>> _parseSeasonalAnime(
  FetchSeasonalAnimeInputType input,
) async {
  final rawResponse = await input.first.makeGraphQLRequest(
    request: input.second,
  );
  final response = json.decode(rawResponse) as Map<String, dynamic>;

  return (response['data']['Page']['media'] as List<dynamic>)
    .cast<Map<String, dynamic>>()
    .where((element) =>
      element['coverImage']['large'] != null &&
      element['description'] != null)
    .map((element) => SummaryModel.fromJson(element))
    .toList();
}
