import 'dart:io';

import 'package:benshi/repository/model/posts.dart';
import 'package:benshi/repository/post_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(
    this.postRepossitory,
  ) : super(PostLoading()) {
    getPostList();
  }

  final PostRepossitory postRepossitory;

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
    final isConnected = await checkInternet();
    if (!isConnected) {
      return emit(PostError(
        errorMessage: 'No internet!\n Please try again.',
      ));
    }

    emit(PostLoading());

    List<Post> postList = await postRepossitory.getPost();

    if (postList.isEmpty) {
      return emit(PostNoData('We are not able to find this location'));
    }
    try {
      emit(
        PostLoaded(
          postList: postList,
        ),
      );
    } catch (e) {
      return emit(
        PostError(
          errorMessage: 'Something went wrong!\n Please try again.',
        ),
      );
    }
  }
}
