import 'dart:convert';
import 'dart:io';

import 'package:animebrowser/api/models/graphql_request_model.dart';
import 'package:animebrowser/utils/exceptions/api_exception.dart';
import 'package:http/http.dart';

class APIProvider {
  static final Uri _baseUri = Uri.parse('https://graphql.anilist.co');

  Future<String> makeGraphQLRequest({
    required GraphQLRequestModel request,
  }) async {
    final response = await post(
      _baseUri,
      headers: {HttpHeaders.contentTypeHeader: ContentType.json.toString()},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        statusCode: response.statusCode,
        reason: response.reasonPhrase,
      );
    }
    return response.body;
  }
}
