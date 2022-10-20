import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rocketx/models/error_model.dart';
import 'package:rocketx/models/reddit_posts.dart';

class RocketXAPI {
  final String domain;
  RocketXAPI({required this.domain});
  RocketXAPI.reddit({this.domain = 'www.reddit.com'});
  RocketXAPI.spacex({this.domain = 'api.spacexdata.com'});

  String getAPIURL({
    List<String>? resources,
    Map<String, String>? parameters,
  }) {
    resources = resources ?? [];
    parameters = parameters ?? {};
    parameters.updateAll((key, value) => Uri.encodeFull(value));
    String queryStr = parameters.isEmpty ? '' : '?';
    parameters.forEach((key, value) {
      queryStr += '${queryStr == '?' ? '' : '&'}$key=$value';
    });
    return 'https://$domain/${resources.join('/')}$queryStr';
  }

  Uri getAPIURI({
    List<String>? resources,
    Map<String, String>? parameters,
  }) {
    debugPrint('${Uri.parse(getAPIURL(
      resources: resources,
      parameters: parameters,
    ))}');
    return Uri.parse(getAPIURL(
      resources: resources,
      parameters: parameters,
    ));
  }

  Future<dynamic> get({
    List<String>? resources,
    Map<String, String>? parameters,
    Map<String, String>? headers,
  }) async {
    headers = headers ?? {};
    headers = {
      ...headers,
    };
    dynamic response;
    await http
        .get(
          getAPIURI(
            resources: resources,
            parameters: parameters,
          ),
          headers: headers,
        )
        .then((value) => response = value)
        .onError((error, stackTrace) {
      return Future.error({});
    });

    return Future.value({
      'code': response.statusCode,
      'json': jsonDecode(response.body),
    });
  }

  Future<RedditPostsModel> getRedditPosts(String count, String profile, String type) async {
    dynamic response = await get(resources: [
      'r',
      profile,
      '$type.json'
    ], parameters: {
      'limit': count,
    });
    if (response['code'] == 200) {
      return (RedditPostsModel(response['json']));
    }
    return RedditPostsModel({});
  }

  Future<dynamic> getSpaceXData() async {
    dynamic response = await get(resources: ['v4', 'launches']);
    if (response['code'] == 200) {
      return (response['json']);
    }
    return ErrorModel(response['code']);
  }
}
