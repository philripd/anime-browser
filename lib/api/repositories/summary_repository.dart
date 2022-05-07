import 'dart:convert';

import 'package:animebrowser/api/api_provider.dart';
import 'package:animebrowser/api/models/graphql_request_model.dart';
import 'package:animebrowser/api/models/summary_model.dart';
import 'package:animebrowser/config/dependencies_config.dart';
import 'package:animebrowser/utils/constants/graphql_queries.dart';
import 'package:animebrowser/utils/helpers/format_query.helper.dart';
import 'package:animebrowser/utils/helpers/tuple.dart';
import 'package:flutter/foundation.dart';

typedef FetchSummaryInputType = Pair<ApiProvider, GraphQLRequestModel>;

abstract class ISummaryRepository {
  Future<List<SummaryModel>> fetchSummary(int page, int perPage);
}

class SummaryRepository implements ISummaryRepository {
  final ApiProvider _apiProvider;

  SummaryRepository() : _apiProvider = getIt.get<ApiProvider>();

  @override
  Future<List<SummaryModel>> fetchSummary(int page, int perPage) async =>
      compute<FetchSummaryInputType, List<SummaryModel>>(
        _parseFetchSummary,
        Pair(
          _apiProvider,
          GraphQLRequestModel(
            query: formatQuery(fetchHomepageQuery),
            variables: {'page': page, 'perPage': perPage},
          ),
        ),
      );
}

Future<List<SummaryModel>> _parseFetchSummary(
  FetchSummaryInputType input,
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
