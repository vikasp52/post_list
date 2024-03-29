import 'package:benshi/repository/model/model.dart';
import 'package:benshi/screens/post_details/post_details.dart';
import 'package:benshi/screens/posts/cubit/post_cubit.dart';
import 'package:benshi/screens/posts/widgets/widgets.dart';
import 'package:benshi/screens/settings/cubit/settings_cubit.dart';
import 'package:benshi/screens/settings/settings.dart';
import 'package:benshi/utils/save_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
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
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        //Execute the code here when user come back the app.
        //In my case, I needed to show if user active or not,
        break;
      case AppLifecycleState.paused:
        //Execute the code the when user leave the app
        Events().sendEmail();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              width: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/banshi_logo.png',
              width: 120,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => BlocProvider(
                  create: (context) => SettingsCubit(),
                  child: Setting(),
                ),
              ),
            ),
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

                if (index + 1 == postData.length) {
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
                    onTap: () {
                      Events().addEvents(post: post);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (_) => PostDetails(
                            postData: post,
                          ),
                        ),
                      );
                    });
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
