import 'package:benshi/screens/post_details/widgets/widgets.dart';
import 'package:benshi/screens/posts/cubit/post_cubit.dart';
import 'package:flutter/material.dart';

class PostDetails extends StatelessWidget {
  final PostData postData;
  const PostDetails({
    Key? key,
    required this.postData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                postData.post.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.network(postData.image),
              const SizedBox(
                height: 20,
              ),
              Text(
                postData.post.body,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AuthodData(
                user: postData.user,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Comments',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              CommentList(
                commentsList: postData.comment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
