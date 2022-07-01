import 'package:benshi/repository/model/posts.dart';
import 'package:benshi/screens/posts/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostList extends StatelessWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    final cubit = context.read<PostCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          'benshi.ai',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, postState) {
          if (postState is PostLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.black,
                ),
              ),
            );
          }

          if (postState is PostError) {
            return Center(
              child: Text(postState.errorMessage),
            );
          }

          if (postState is PostLoaded) {
            return ListView.builder(
              controller: _scrollController
                ..addListener(() {
                  if (_scrollController.offset ==
                      _scrollController.position.maxScrollExtent) {
                    cubit.getPostList(
                      page: cubit.currentPage++,
                    );
                  }
                }),
              itemCount: postState.postList.length,
              itemBuilder: (context, index) {
                Post post = postState.postList[index];
                return Card(
                  child: ListTile(
                    title: Text(post.title ?? ''),
                    subtitle: Text(post.id.toString()),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
