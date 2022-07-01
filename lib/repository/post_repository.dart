import 'dart:convert';
import 'package:benshi/network/constants.dart';
import 'package:benshi/repository/model/model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PostRepossitory {
  Future<List<Post>> getPost({
    required int page,
  }) async {
    const limit = 10;
    String url =
        Constants.baseUrl + Constants.posts + '?_page=$page&_limit=$limit';

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

  Future<User?> getUserData(String userId) async {
    String url = Constants.baseUrl + Constants.user + userId;

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var parsed = jsonDecode(response.body);

        User user = User.fromJson(parsed);

        return user;
      } else {
        throw Exception('Failed to user load data');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception $e');
      }
      return null;
    }
  }

  Future<List<Comment>> getComments(String postId) async {
    String url = Constants.baseUrl + Constants.comments + postId;

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        var parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        var comments = parsed
            .map<Comment>(
              (json) => Comment.fromJson(
                json,
              ),
            )
            .toList();
        return comments;
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception $e');
      }
      return [];
    }
  }

  String? getImage({
    required String postTitle,
    required double width,
    required double height,
  }) {
    String url = Constants.baseUrl +
        Constants.imageUrl +
        'sha256$postTitle/$width/$height';

    try {
      return url;
    } catch (e) {
      if (kDebugMode) {
        print('Exception $e');
      }
      return null;
    }
  }
}
