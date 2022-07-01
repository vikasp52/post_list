import 'package:benshi/repository/model/posts.dart';
import 'package:benshi/screens/posts/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('_scrollController called');
        context.read<PostCubit>().getPostList(
            //page: cubit.currentPage += 1,
            'Post List');
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final cubit = context.read<PostCubit>();

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
          // if (postState is PostLoading) {
          //   return const Center(
          //     child: CircularProgressIndicator(
          //       valueColor: AlwaysStoppedAnimation<Color>(
          //         Colors.black,
          //       ),
          //     ),
          //   );
          // }

          if (postState is PostError) {
            return Center(
              child: Text(postState.errorMessage),
            );
          }

          if (postState is PostLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: postState.postList.length,
              itemBuilder: (context, index) {
                Post post = postState.postList[index];

                if (index == postState.postList.length) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      ),
                    ),
                  );
                }
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
