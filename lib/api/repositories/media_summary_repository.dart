import 'dart:convert';

import 'package:animebrowser/api/api_provider.dart';
import 'package:animebrowser/api/models/graphql_request_model.dart';
import 'package:animebrowser/api/models/media_summary_model.dart';
import 'package:animebrowser/api/queries/media_overall_query.dart';
import 'package:animebrowser/config/dependencies_config.dart';
import 'package:animebrowser/utils/helpers/format_query.dart';
import 'package:animebrowser/utils/helpers/tuple.dart';
import 'package:flutter/foundation.dart';

typedef FetchSummaryInputType = Pair<APIProvider, GraphQLRequestModel>;

abstract class IMediaSummaryRepository {
  Future<List<MediaSummaryModel>> fetchSummary(int page, int perPage);
}

class MediaSummaryRepository implements IMediaSummaryRepository {
  final APIProvider _apiProvider;

  MediaSummaryRepository() : _apiProvider = getIt.get<APIProvider>();

  @override
  Future<List<MediaSummaryModel>> fetchSummary(int page, int perPage) async =>
    compute<FetchSummaryInputType, List<MediaSummaryModel>>(
      _parseSummary,
      Pair(
        _apiProvider,
        GraphQLRequestModel(
          query: formatQuery(mediaOverallQuery),
          variables: {
            'page': page,
            'perPage': perPage
          },
        ),
      ),
    );
}

Future<List<MediaSummaryModel>> _parseSummary(
  FetchSummaryInputType input,
) async {
  final rawResponse = await input.first.makeGraphQLRequest(
    request: input.second,
  );
  final response = json.decode(rawResponse) as Map<String, dynamic>;

  return (response['data']['Page']['media'] as List<dynamic>)
    .cast<Map<String, dynamic>>()
    .where((element) =>
      element['coverImage']['extraLarge'] != null &&
      element['description'] != null)
    .map((element) => MediaSummaryModel.fromJson(element))
    .toList();
}
