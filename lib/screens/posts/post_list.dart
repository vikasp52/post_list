import 'package:benshi/repository/model/comment.dart';
import 'package:benshi/repository/model/posts.dart';
import 'package:benshi/repository/model/user.dart';
import 'package:benshi/screens/post_details/post_details.dart';
import 'package:benshi/screens/posts/cubit/post_cubit.dart';
import 'package:benshi/screens/posts/widgets/widgets.dart';
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
    context.read<PostCubit>().getPostList();
    getNextPosts();
  }

  void getNextPosts() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<PostCubit>().getPostList();
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
      body: StreamBuilder<List<PostData>>(
        stream: cubit.postController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.black,
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('There is some issue'),
            );
          }

          if (snapshot.hasData) {
            List<PostData> postData = snapshot.data!;
            return ListView.builder(
              controller: _scrollController,
              itemCount: postData.length,
              itemBuilder: (_, index) {
                PostData post = postData[index];
                // User user = postData.user[index];
                // List<Comment> comments = postData.comment[index];
                // String image = postData.image[index];

                if (index + 1 == postData.length) {
                  print('Show progressbar');
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        bottom: 30,
                      ),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.black,
                        ),
                      ),
                    ),
                  );
                }
                return CustomListItems(
                  title: post.post.title,
                  desc: post.post.body,
                  name: post.user.name ?? '',
                  commentCount: post.comment.length.toString(),
                  imagePath: post.image,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (_) => PostDetails(
                        postData: post,
                      ),
                    ),
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


// BlocBuilder<PostCubit, PostState>(
//         builder: (context, postState) {
//           if (postState is PostLoading) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(
//                   Colors.black,
//                 ),
//               ),
//             );
//           }

//           if (postState is PostError) {
//             return Center(
//               child: Text(postState.errorMessage),
//             );
//           }

//           if (postState is PostLoaded) {
//             return ListView.builder(
//               controller: _scrollController,
//               itemCount: postState.posts.posts.length,
//               itemBuilder: (context, index) {
//                 Post post = postState.posts.posts[index];
//                 User user = postState.posts.users[index];
//                 List<Comment> comments = postState.posts.comments[index];
//                 String images = postState.posts.images[index];

//                 return Card(
//                   child: ListTile(
//                     title: Text(post.title),
//                     subtitle: Column(
//                       children: [
//                         Text('Post id-' + post.id.toString()),
//                         Text('Name-' + user.name.toString()),
//                         Text('Comments-' + comments.length.toString()),
//                       ],
//                     ),
//                     trailing: Image.network(images),
//                   ),
//                 );
//               },
//             );
//           }
//           return const SizedBox();
//         },
//       ),
