import 'dart:convert';

import 'package:animebrowser/api/api_provider.dart';
import 'package:animebrowser/api/models/media_details_model.dart';
import 'package:animebrowser/api/models/graphql_request_model.dart';
import 'package:animebrowser/api/queries/media_details_query.dart';
import 'package:animebrowser/config/dependencies_config.dart';
import 'package:animebrowser/utils/helpers/format_query.dart';
import 'package:animebrowser/utils/helpers/tuple.dart';
import 'package:flutter/foundation.dart';

typedef FetchMediaInputType = Pair<APIProvider, GraphQLRequestModel>;

abstract class IDetailsRepository {
  Future<MediaDetailsModel> fetchMedia(int mediaID);
}

class DetailsRepository implements IDetailsRepository {
  final APIProvider _apiProvider;

  DetailsRepository() : _apiProvider = getIt.get<APIProvider>();

  @override
  Future<MediaDetailsModel> fetchMedia(int mediaID) async =>
    compute<FetchMediaInputType, MediaDetailsModel>(
      _parseFetchMedia,
      Pair(
        _apiProvider,
        GraphQLRequestModel(
          query: formatQuery(mediaDetailsQuery),
          variables: {
            'id': mediaID
          },
        ),
      ),
    );
}

Future<MediaDetailsModel> _parseFetchMedia(FetchMediaInputType input) async {
  final rawResponse = await input.first.makeGraphQLRequest(
    request: input.second,
  );
  final response = json.decode(rawResponse) as Map<String, dynamic>;
  return MediaDetailsModel.fromJson(
    response['data']['Media'] as Map<String, dynamic>,
  );
}
