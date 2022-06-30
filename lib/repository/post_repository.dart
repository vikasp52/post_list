import 'dart:convert';
import 'package:benshi/network/constants.dart';
import 'package:benshi/repository/model/posts.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PostRepossitory {
  Future<List<Post>> getPost() async {
    String url = Constants.baseUrl + Constants.posts;

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        var posts = parsed
            .map<Post>(
              (json) => Post.fromJson(
                json,
              ),
            )
            .toList();
        return posts;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception $e');
      }
      return [];
    }
  }
}
