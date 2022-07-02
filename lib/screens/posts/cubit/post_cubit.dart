import 'dart:async';
import 'dart:io';

import 'package:benshi/repository/model/model.dart';
import 'package:benshi/repository/post_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(
    this.postRepossitory,
  ) : super(PostLoading());

  final PostRepossitory postRepossitory;
  List<Post> posts = [];
  List<User> users = [];
  List<List<Comment>> comments = [];
  List<String> images = [];
  int _currentPage = 1;
  User? _previousUser;
  List<PostData> postData = [];
  var postController = StreamController<List<PostData>>();

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  Future<void> getPostList() async {
    List<User> userList = [];
    List<List<Comment>> commentList = [];
    List<String> imageList = [];
    List<PostData> postDataList = [];

    final isConnected = await checkInternet();
    if (!isConnected) {
      throw Exception('No internet connection');
    }

    emit(PostLoading());

    List<Post> postList = await postRepossitory.getPost(
      page: _currentPage++,
    );

    if (postList.isEmpty) {
      throw Exception('No internet connection');
    }
    try {
      print('posts: ${postList.length}');
      await Future.forEach(
        postList,
        (Post post) async {
          print('Post in loop: ${post.id}');
          User user = await getUser(post.userId);

          print('user: ${user.email}');
          userList.add(user);

          List<Comment> comments = await getComments(post.id);
          print('comments: ${comments.length}');
          commentList.add(comments);

          String image = await postRepossitory.getImage(
            postTitle: post.title,
            width: 500,
            height: 200,
          );

          imageList.add(image);

          postDataList.add(PostData(
            post: post,
            user: user,
            comment: comments,
            image: image,
          ));
        },
      );

      posts.addAll(postList);

      users.addAll(userList);

      comments.addAll(commentList);

      images.addAll(imageList);

      postData.addAll(postDataList);

      print('comments are: ${comments.length}');

      postController.add(postData);
    } catch (e) {
      throw Exception('Somthing went wrong!');
    }
  }

  Future<void> getPostList1() async {
    List<User> userList = [];
    List<List<Comment>> commentList = [];
    List<String> imageList = [];

    final isConnected = await checkInternet();
    if (!isConnected) {
      return emit(
        PostError(
          errorMessage: 'No internet!\n Please try again.',
        ),
      );
    }

    emit(PostLoading());

    List<Post> postList = await postRepossitory.getPost(
      page: _currentPage++,
    );

    if (postList.isEmpty) {
      return emit(PostNoData('We don\'t have any post now.'));
    }
    try {
      print('posts: ${postList.length}');
      await Future.forEach(
        postList,
        (Post post) async {
          print('Post in loop: ${post.id}');
          User user = await getUser(post.userId);

          print('user: ${user.email}');
          userList.add(user);

          List<Comment> comments = await getComments(post.id);
          print('comments: ${comments.length}');
          commentList.add(comments);

          String image = await postRepossitory.getImage(
            postTitle: post.title,
            width: 50,
            height: 50,
          );

          print('Image: $image');

          imageList.add(image);
        },
      );

      posts.addAll(postList);

      users.addAll(userList);

      comments.addAll(commentList);

      images.addAll(imageList);

      print('comments are: $comments');

      // emit(
      //   PostLoaded(
      //     posts: PostData(
      //       post: posts,
      //       user: users,
      //       comment: comments,
      //       image: images,
      //     ),
      //   ),
      // );
    } catch (e) {
      return emit(
        PostError(
          errorMessage: 'Something went wrong!\n Please try again.',
        ),
      );
    }
  }

  Future<User> getUser(
    int useId,
  ) async {
    if (_previousUser == null || _previousUser?.id != useId) {
      var user = await postRepossitory.getUserData(useId);
      _previousUser = user;
      return user;
    } else {
      return _previousUser!;
    }
  }

  Future<List<Comment>> getComments(int postId) async {
    List<Comment> comments = await postRepossitory.getComments(postId);

    return comments;
  }
}

class PostData {
  final Post post;
  final User user;
  final List<Comment> comment;
  final String image;

  PostData({
    required this.post,
    required this.user,
    required this.comment,
    required this.image,
  });
}
