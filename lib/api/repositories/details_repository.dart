import 'dart:convert';

import 'package:animebrowser/api/api_provider.dart';
import 'package:animebrowser/api/models/details_model.dart';
import 'package:animebrowser/api/models/graphql_request_model.dart';
import 'package:animebrowser/config/dependencies_config.dart';
import 'package:animebrowser/utils/constants/graphql_queries.dart';
import 'package:animebrowser/utils/helpers/format_query.helper.dart';
import 'package:animebrowser/utils/helpers/tuple.dart';
import 'package:flutter/foundation.dart';

typedef FetchMediaInputType = Pair<ApiProvider, GraphQLRequestModel>;

abstract class IDetailsRepository {
  Future<DetailsModel> fetchMedia(int mediaID);
}

class DetailsRepository implements IDetailsRepository {
  final ApiProvider _apiProvider;

  DetailsRepository() : _apiProvider = getIt.get<ApiProvider>();

  @override
  Future<DetailsModel> fetchMedia(int mediaID) async =>
      compute<FetchMediaInputType, DetailsModel>(
        _parseFetchMedia,
        Pair(
          _apiProvider,
          GraphQLRequestModel(
            query: formatQuery(fetchDetailsQuery),
            variables: {'id': mediaID},
          ),
        ),
      );
}

Future<DetailsModel> _parseFetchMedia(FetchMediaInputType input) async {
  final rawResponse = await input.first.makeGraphQLRequest(
    request: input.second,
  );
  final response = json.decode(rawResponse) as Map<String, dynamic>;
  return DetailsModel.fromJson(
    response['data']['Media'] as Map<String, dynamic>,
  );
}
